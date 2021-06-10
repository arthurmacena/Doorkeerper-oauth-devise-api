module Hipag
  module Entities
    class UserAdressField < Grape::Entity
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