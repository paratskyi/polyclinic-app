Rails.application.routes.draw do
  root 'home#index'

  devise_for :profiles
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :profiles, only: [:index, :show, :edit, :update]
  resources :appointments, only: [:new, :show, :create]
end
