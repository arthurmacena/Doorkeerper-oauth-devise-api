module Hipag
  module Entities
    class User < Grape::Entity
      expose :email
      expose :phone
      expose :email
      expose :first_name
      expose :last_name
      expose :birthdate
      expose :cpf
      expose :cep
      expose :adress
      expose :number
      expose :complement
      expose :neighborhood
      expose :city
      expose :state
      expose :country
    end
  end
end