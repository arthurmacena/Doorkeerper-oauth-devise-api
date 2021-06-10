module Hipag
  module V1
    class Sessions < Grape::API

      helpers do
        def generate_refresh_token
          loop do
            # generate a random token string and return it, 
            # unless there is already another token with the same string
            token = SecureRandom.hex(32)
            break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
          end
        end
      end

      resources :sign_in do
        params do
          requires :email, type: String, desc: "User's email."
          requires :client_id, type: String, desc: "User's client id"
        end
        post do 
          user = User.find_by(email: params[:email])
          client_app = Doorkeeper::Application.find_by(uid: params[:client_id])
          # return render(json: { error: 'Invalid client ID'}, status: 403) unless client_app

          if user.present?
            access_token = Doorkeeper::AccessToken.create(
              resource_owner_id: user.id,
              application_id: client_app.id,
              refresh_token: generate_refresh_token,
              expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
              scopes: ''
            )
          end

          present access_token, with: Hipag::Entities::AccessToken
        end
      end

      resources :sign_out do
        params do
          requires :email, type: String, desc: "User's email."
          requires :client_id, type: String, desc: "User's client id"
        end
        delete do
          user = User.find_by(email: params[:email])
          client_app = Doorkeeper::Application.find_by(uid: params[:client_id])
          # return render(json: { error: 'Invalid client ID'}, status: 403) unless client_app

          number = Doorkeeper::AccessToken.revoke_all_for(client_app.id, user)

          present number
        end
      end
    end
  end
end