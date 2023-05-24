require 'rails_helper'

RSpec.describe 'Appointments' do
  describe 'POST /create' do
    subject(:create_appointment) do
      post appointments_path, params: { appointment: appointment_params }
    end

    let(:created_appointment) { Appointment.last }
    let(:appointment_attributes) { created_appointment.attributes }

    let(:user_profile) { create(:profile, :user) }
    let(:doctor_profile) { create(:profile, :doctor) }
    let(:user) { user_profile.user }
    let(:doctor) { doctor_profile.user }

    let(:appointment_params) do
      {
        user_id: user.id,
        doctor_id: doctor.id
      }
    end

    before { sign_in user_profile }

    shared_examples 'appointment created' do
      it 'creates appointment successfully' do
        expect { create_appointment }.to change(Appointment, :count).by(1)
        expect(appointment_attributes).to match hash_including(
          'id' => created_appointment.id,
          'user_id' => user.id,
          'doctor_id' => doctor.id,
          'status' => 'planned',
          'prescription' => nil
        )
        expect(create_appointment).to redirect_to appointment_path(created_appointment)
      end
    end

    shared_examples 'appointment does not create' do
      let(:errors) { nil }

      it 'does not create appointment' do
        expect { create_appointment }.not_to(change(Appointment, :count))
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'shows errors' do
        subject
        expect(response.body).to include "#{errors.count} error prohibited this appointment from being saved:"
        errors.each do |error|
          expect(response.body).to include error
        end
      end
    end

    context 'with valid params' do
      include_examples 'appointment created'

      context 'when signed_in as doctor' do
        before { sign_in doctor_profile }

        it 'raises CanCan::AccessDenied' do
          expect { create_appointment }.not_to(change(Appointment, :count))
          expect(create_appointment).to redirect_to root_path
          follow_redirect!
          expect(response.body).to include 'You are not authorized to access this page.'
        end
      end

      context 'when doctor has 10 appointments' do
        let!(:appointments) { create_list(:appointment, 10, user: user, doctor: doctor) }

        include_examples 'appointment does not create' do
          let(:errors) { ['This doctor is too busy'] }
        end

        context 'with on of appointment in completed status' do
          before { appointments.last.completed! }

          include_examples 'appointment created'
        end
      end
    end
  end
end
