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
FactoryBot.define do
  factory :appointment do
    user { FactoryBot.create(:user) }
    doctor { FactoryBot.create(:doctor) }
    prescription { FFaker::FreedomIpsum.paragraph }

    trait :planned do
      status { 'planned' }
    end

    trait :completed do
      status { 'completed' }
    end
  end
end
