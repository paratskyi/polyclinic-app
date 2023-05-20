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
require 'rails_helper'

RSpec.describe Appointment do
  subject { create(:appointment) }

  describe 'columns' do
    it { is_expected.to have_db_column(:user_id).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:doctor_id).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:status).of_type(:enum).with_options(null: false, default: 'planned') }
    it { is_expected.to have_db_column(:prescription).of_type(:text) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:doctor) }
  end
end
