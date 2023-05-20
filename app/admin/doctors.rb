ActiveAdmin.register Doctor do
  permit_params :first_name, :last_name, :education, :category_id,
                profile_attributes: %i[email phone_number password password_confirmation]

  form do |f|
    f.semantic_errors *f.object.errors.attribute_names
    f.object.profile = Profile.new if f.object.profile.nil?

    f.inputs 'Doctor details' do
      f.input :category
      f.input :first_name
      f.input :last_name
      f.input :education
    end

    f.inputs 'Profile details' do
      f.has_many :profile, heading: false, new_record: false do |profile|
        profile.input :email
        profile.input :phone_number
        profile.input :password if f.object.new_record?
        profile.input :password_confirmation if f.object.new_record?
      end
    end

    f.actions
  end

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :category
      row :education
      row :created_at
      row :updated_at
    end
  end

  sidebar 'Profile details', only: :show do
    attributes_table_for resource.profile do
      row :email
      row :phone_number
    end
  end
end
