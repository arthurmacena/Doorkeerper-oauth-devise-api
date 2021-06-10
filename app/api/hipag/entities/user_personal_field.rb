module Hipag
  module Entities
    class UserPersonalField < Grape::Entity
      expose :phone
      expose :email
      expose :first_name
      expose :last_name
      expose :birthdate
      expose :cpf
    end
  end
end