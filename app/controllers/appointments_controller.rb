class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[show edit update]

  def index
    @appointments = current_profile.user.appointments.order(:status)
  end

  def show; end

  def new
    @appointment = Appointment.new
  end

  def edit; end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      flash[:success] = 'Appointment was successfully created!'
      redirect_to @appointment
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @appointment.update(appointment_params)
      @appointment.completed! if @appointment.prescription_previously_changed?
      flash[:success] = 'Appointment was successfully processed!'
      redirect_to @appointment
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:user_id, :doctor_id, :prescription)
  end
end
