# frozen_string_literal: true

module Profiles
  class RegistrationsController < Devise::RegistrationsController

    def create
      build_resource(sign_up_params)

      resource.save
      yield resource if block_given?
      if resource.persisted?
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        resource.errors.merge!(resource.user) # Merge User errors to Profile
        respond_with resource
      end
    end

    protected

    def build_resource(hash = {})
      ActiveRecord::Base.transaction do
        if action_name == 'create'
          user = User.create(first_name: hash.delete(:first_name), last_name: hash.delete(:last_name))
          hash[:user] = user
        end
        super
      end
    end
  end
end
