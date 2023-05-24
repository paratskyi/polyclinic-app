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
require 'rails_helper'

RSpec.describe Profile do
  subject { create(:profile) }

  describe 'columns' do
    it { is_expected.to have_db_column(:email).of_type(:string).with_options(null: false, default: '') }
    it { is_expected.to have_db_column(:phone_number).of_type(:string).with_options(null: false, default: '') }
    it { is_expected.to have_db_column(:encrypted_password).of_type(:string).with_options(null: false, default: '') }
    it { is_expected.to have_db_column(:reset_password_token).of_type(:string) }
    it { is_expected.to have_db_column(:reset_password_sent_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:remember_created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:user_type).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:user_id).of_type(:integer).with_options(null: false) }
  end

  describe 'indexes' do
    it { is_expected.to have_db_index(:phone_number).unique }
    it { is_expected.to have_db_index(:email).unique }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:phone_number) }
    it { is_expected.to validate_uniqueness_of(:phone_number).case_insensitive }
    it { is_expected.to validate_numericality_of(:phone_number) }
    it { is_expected.to validate_length_of(:phone_number).is_at_least(10).is_at_most(15) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to accept_nested_attributes_for(:user).allow_destroy(false) }
  end
end
