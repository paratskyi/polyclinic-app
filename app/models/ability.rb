# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(profile)
    return if profile.blank?

    can :read, Profile
    can %i[edit update], Profile, id: profile.id

    if profile.user?
      can :read, Appointment, user_id: profile.user_id
      can %i[new create], Appointment
      cannot %i[edit update], Appointment
    end

    if profile.doctor?
      can :read, Appointment, doctor_id: profile.user_id
      can %i[edit update], Appointment, doctor_id: profile.user_id, status: :planned
      cannot %i[new create], Appointment
    end
  end
end
