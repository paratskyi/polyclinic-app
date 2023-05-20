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
FactoryBot.define do
  factory :doctor do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    education { FFaker::Education.school }
    category { FactoryBot.create(:category) }
  end
end
