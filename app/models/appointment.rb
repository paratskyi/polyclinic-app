# == Schema Information
#
# Table name: appointments
#
#  id           :bigint           not null, primary key
#  user_id      :bigint           not null
#  doctor_id    :bigint           not null
#  status       :enum             default("planned"), not null
#  prescription :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :doctor

  enum :status, { planned: 'planned', completed: 'completed' }

  validate :appointment_count_within_limit, on: :create

  private

  def appointment_count_within_limit
    return if doctor.appointments.planned.count < Doctor::APPOINTMENT_LIMIT

    errors.add(:base, 'This doctor is too busy')
  end
end
