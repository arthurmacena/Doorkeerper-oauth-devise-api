module Hipag
  module V1
    class UserRegistrations < Grape::API

      resources :user_registration do
        desc 'user phone registration'
        params do
          requires :phone, type: String, desc: "User's phone"
        end
        post '/phone_registration' do
          phone = params[:phone]

          User.create!({
                         phone: phone
                       })

          return "verification code is: XXXX"
        end

        desc 'user personal fields'
        params do
          requires :phone, type: String, desc: "User's phone"
          requires :verification_code, type: String, desc: "User's phone's verification code"
          requires :email, type: String, desc: "User's email"
          requires :first_name, type: String, desc: "User's first name"
          requires :last_name, type: String, desc: "User's last name"
          requires :birthdate, type: Date, desc: "User's birthdate"
          requires :cpf, type: String, desc: "User's cpf"
        end
        put '/personal_fields' do
          phone = params[:phone]
          verification_code = params[:verificationCode]
          email = params[:email]
          first_name = params[:first_name]
          last_name = params[:last_name]
          birthdate = params[:birthdate]
          cpf = params[:cpf]

          if verification_code.present?
            if verification_code != "XXXX"
              :error
            end
          end

          user = User.find_by(phone: phone)
          user.update(email: email, first_name: first_name, last_name: last_name,
                      birthdate: birthdate, cpf: cpf
                     )

          present user, with: Hipag::Entities::UserPersonalField
        end

        desc 'user adress fields'
        params do
          requires :phone,        type: String,       desc: "User's phone"
          requires :cep,          type: String,       desc: "User's cep"
          requires :adress,       type: String,       desc: "User's adress"
          requires :number,       type: String,       desc: "User's number"
          optional :complement,   type: String,       desc: "User's complement"
          requires :neighborhood, type: String,       desc: "User's neighborhood"
          requires :city,         type: String,       desc: "User's city"
          requires :state,        type: String,       desc: "User's state"
          requires :country,      type: String,       desc: "User's country"
        end
        put '/adress_fields' do
          phone =        params[:phone]
          cep =          params[:cep]
          adress =       params[:adress]
          number =       params[:number]
          complement =   params[:complement]
          neighborhood = params[:neighborhood]
          city =         params[:city]
          state =        params[:state]
          country =      params[:country]

          user = User.find_by(phone: phone)
          user.update(cep: cep,
                      adress: adress,
                      number: number,
                      complement: complement,
                      neighborhood: neighborhood,
                      city: city,
                      state: state,
                      country: country
                     )

          present user, with: Hipag::Entities::UserPersonalField
        end

        desc 'user adress fields'
        params do
          requires :phone,                  type: String,       desc: "User's phone"
          requires :password,               type: String,       desc: "User's password"
          requires :password_confirmation,  type: String,       desc: "User's password confirmation"
        end
        put '/password_fields' do
          phone =                  params[:phone]
          password =               params[:password]
          password_confirmation =  params[:password_confirmation]

          unless password == password_confirmation
            :error
          end

          user = User.find_by(phone: phone)
          user.update(password: password,
                      password_confirmation: password_confirmation,
                     )

          present user, with: Hipag::Entities::UserPersonalField
        end
      end
    end
  end
end