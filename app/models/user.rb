# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  first_name :string           not null
#  last_name  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  PUBLIC_ATTRIBUTES = %w[first_name last_name].freeze

  has_one :profile, as: :user, dependent: :destroy

  has_many :appointments, dependent: :nullify
  has_many :doctors, through: :appointments

  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
end
