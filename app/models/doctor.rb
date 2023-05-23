# == Schema Information
#
# Table name: doctors
#
#  id          :bigint           not null, primary key
#  first_name  :string           not null
#  last_name   :string           not null
#  education   :string
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Doctor < ApplicationRecord
  APPOINTMENT_LIMIT = 10
  PUBLIC_ATTRIBUTES = %w[first_name last_name education category].freeze

  belongs_to :category

  has_many :appointments, dependent: :nullify
  has_many :users, through: :appointments

  has_one :profile, as: :user, dependent: :destroy

  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
  validates :education, length: { maximum: 100 }
end
