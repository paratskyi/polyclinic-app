class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[show edit update]
  def show; end

  def edit; end

  def update
    if @profile.update(profile_params)
      flash[:success] = 'Profile was successfully updated!'
      redirect_to @profile
    else
      render 'edit'
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    # params.require(:profile).permit(:name, :email)
    params.require(:profile).permit(:first_name, :last_name, profile_attributes: %i[email phone_number])
  end
end
