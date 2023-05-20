Rails.application.routes.draw do
  root 'home#index'

  devise_for :profiles, controllers: { registrations: 'profiles/registrations' }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resource :profile, only: :show
end
