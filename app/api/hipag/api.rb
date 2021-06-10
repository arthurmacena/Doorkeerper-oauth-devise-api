module Hipag
  class API < Grape::API
    version 'v1', using: :path
    format :json
    prefix :api


    mount Hipag::V1::Users
    mount Hipag::V1::Sessions
    mount Hipag::V1::UserRegistrations
  end
 end