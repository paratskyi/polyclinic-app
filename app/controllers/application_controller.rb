class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_profile!

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to :root
  end

  alias current_user current_profile

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_type, :email, :phone_number, user_attributes: [:first_name, :last_name]])
  end
end
