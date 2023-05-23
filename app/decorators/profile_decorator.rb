class ProfileDecorator < ApplicationDecorator
  delegate_all

  def full_name
    "#{object.user.first_name} #{object.user.last_name}"
  end
end
