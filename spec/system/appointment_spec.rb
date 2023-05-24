require 'rails_helper'

RSpec.describe Appointment, js: true, type: :system do
  before do
    sign_in doctor_profile
  end

  let(:user_profile) { create(:profile, :user) }
  let(:doctor_profile) { create(:profile, :doctor) }
  let(:user) { user_profile.user }
  let(:doctor) { doctor_profile.user }
  let!(:appointment) { create(:appointment, user:, doctor:) }

  describe 'process' do
    subject(:process_appointment) do
      fill_form!
      click_button 'Process'
    end

    before { visit appointment_path(appointment) }

    let(:prescription) { FFaker::FreedomIpsum.paragraph }

    let(:fill_form!) do
      fill_in 'Prescription', with: prescription
    end

    it 'processes appointment' do
      click_button 'Process appointment'
      expect { process_appointment }.not_to(change(described_class, :count))
      within('main.appointment-section') do
        expect(page).to have_content('Appointment details')
        expect(page).to have_content('completed')
        expect(page).to have_content(prescription)
        expect(page).not_to have_content('button', exact: 'Process appointment')
      end
    end
  end
end
