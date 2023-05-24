class ProfilesController < ApplicationController
  load_and_authorize_resource

  before_action :set_profile, only: %i[show edit update]
  before_action :set_scope, only: %i[index]

  PROFILE_LOADER_MAPPER = {
    'doctor' => Profiles::LoadDoctorProfiles,
    'user' => Profiles::LoadUserProfiles
  }.freeze

  def index
    @profiles = PROFILE_LOADER_MAPPER[@scope].perform(filter_params)
  end

  def show
    session[:doctor_id] = @profile.user.id if @profile.doctor?
  end

  def edit
    authorize! :edit, @profile
  end

  def update
    authorize! :update, @profile
    if @profile.update(profile_params)
      flash[:success] = 'Profile was successfully updated!'
      redirect_to @profile
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def set_scope
    @scope = params[:scope] || 'doctor'
  end

  def filter_params
    params.require(:filters).permit(Profiles::LoadDoctorProfiles::DOCTOR_FILTERS)
  rescue ActionController::ParameterMissing
    nil
  end

  def profile_params
    params.require(:profile).permit(
      :user_type, :email, :phone_number,
      user_attributes: Profile::PUBLIC_ATTRIBUTES_MAPPER[current_profile.user_type.downcase].map(&:to_sym)
    )
  end
end
