# frozen_string_literal: true

module Profiles
  class RegistrationsController < Devise::RegistrationsController
    protected

    def build_resource(hash = {})
      ActiveRecord::Base.transaction do
        if hash.any?
          user = User.create!(first_name: hash.delete(:first_name), last_name: hash.delete(:last_name))
          hash[:user] = user
        end
        # TODO: Add user validation errors to profile
        super
      end
    end
  end
end
