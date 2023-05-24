# frozen_string_literal: true

module Profiles
  class Base < ApplicationService
    PROFILE_FILTERS = []

    def initialize(filters)
      @filters = filters
    end

    def perform
      load_collection
      filter_collection! unless @filters.nil?
      @collection
    end

    private

    def load_collection
      raise NotImplementedError, 'method should be implemented in concrete class'
    end

    def filter_collection!
      raise NotImplementedError, 'method should be implemented in concrete class'
    end
  end
end
