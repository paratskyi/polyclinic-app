# == Schema Information
#
# Table name: profiles
#
#  id                     :bigint           not null, primary key
#  phone_number           :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class Profile < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  validates :phone_number, presence: true,
                           uniqueness: true,
                           numericality: true,
                           length: { minimum: 10, maximum: 15 }

  def email_required?
    false
  end

  def will_save_change_to_email?
    false
  end
end
