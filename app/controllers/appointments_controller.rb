class AppointmentsController < ApplicationController

  def show
    @appointment = Appointment.find(params[:id])
  end

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      flash[:success] = 'Appointment was successfully created!'
      redirect_to @appointment
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:user_id, :doctor_id)
  end
end
