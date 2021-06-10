Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  mount Hipag::API => '/'

  namespace :api do
    resources :users, only: %i[create]
  end
end