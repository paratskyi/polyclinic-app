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
FactoryBot.define do
  factory :profile do
    phone_number { FFaker::PhoneNumberUA.international_mobile_phone_number.sub('-', '').delete(" \t\r\n") }
    password { FFaker::Internet.password }
  end
end
