module Hipag
  module Entities
    class AccessToken < Grape::Entity
      expose :refresh_token
      expose :token
      expose :expires_in
      expose :resource_owner_id
      expose :application_id
      expose :token_type
    end
  end
end