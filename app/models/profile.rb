# == Schema Information
#
# Table name: profiles
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  phone_number           :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_type              :string           not null
#  user_id                :bigint           not null
#
class Profile < ApplicationRecord
  USER_TYPES = %i[user doctor].freeze
  PUBLIC_ATTRIBUTES = %w[email phone_number].freeze

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  belongs_to :user, polymorphic: true, dependent: :destroy, optional: false, autosave: true
  accepts_nested_attributes_for :user

  validates :phone_number, presence: true,
                           uniqueness: true,
                           numericality: true,
                           length: { minimum: 10, maximum: 15 }

  scope :doctors, -> { where(user_type: 'Doctor') }

  def user?
    user_type == 'User'
  end

  def doctor?
    user_type == 'Doctor'
  end

  def user_attributes=(attributes)
    return unless USER_TYPES.include?(user_type.underscore.to_sym)

    self.user ||= user_type.constantize.new
    self.user.assign_attributes(attributes)
  end
end
