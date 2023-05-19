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
FactoryBot.define do
  factory :profile do
    email { FFaker::Internet.email }
    phone_number { FFaker::PhoneNumberUA.international_mobile_phone_number.sub('-', '').delete(" \t\r\n") }
    password { FFaker::Internet.password }
    user { FactoryBot.create(:user) }

    trait :with_user_type_user do
      user { FactoryBot.create(:user) }
    end
  end
end
