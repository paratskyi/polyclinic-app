class DoctorDecorator < ApplicationDecorator
  delegate_all

  def category
    object.category.name
  end
end
