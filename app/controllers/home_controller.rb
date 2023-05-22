# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    redirect_to new_profile_session_path unless profile_signed_in?
  end
end
