# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Category do
  subject { create(:category) }

  describe 'columns' do
    it { is_expected.to have_db_column(:name).with_options(null: false) }
  end

  describe 'indexes' do
    it { is_expected.to have_db_index(:name).unique }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end
end
