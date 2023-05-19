Rails.application.routes.draw do
  devise_for :profiles, controllers: { registrations: 'profiles/registrations' }

  root 'home#index'
end
