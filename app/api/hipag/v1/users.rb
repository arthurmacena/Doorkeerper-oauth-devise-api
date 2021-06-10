require 'doorkeeper/grape/helpers'
module Hipag
  module V1
    class Users < Grape::API
      helpers Doorkeeper::Grape::Helpers
      helpers Pundit

      before do
        doorkeeper_authorize!
      end

      helpers do
        def current_user
          current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id])
        end
      end

      resource :users do
        desc 'check current user'
        get '/current_user' do
          current_user

          present current_user, with: Hipag::Entities::User
        end

        desc 'Return list of users'
        get do
          current_user
          authorize current_user, :index?
          users = User.all
          present users, with: Hipag::Entities::User
        end

        desc 'Return a specific user'
        route_param :id do
          get do
            current_user
            authorize current_user, :show?
            user = User.find(params[:id])
            present user, with: Hipag::Entities::User
            end
        end

        desc 'Create a user'
        params do
          requires :email, type: String, desc: "User's email."
          requires :password, type: String, desc: "User's password."
        end
        post do
          current_user
          authorize current_user, :create?
          user = User.new(email: params[:email], password: params[:password])
          user.save!
          present user, with: Hipag::Entities::User
        end
      end
    end
  end
end