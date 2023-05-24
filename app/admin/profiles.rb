ActiveAdmin.register Profile, as: 'Doctor' do
  permit_params :email, :phone_number, :password, :password_confirmation, :user_type,
                user_attributes: %i[first_name last_name education category_id]

  form do |f|
    f.semantic_errors *f.object.errors.attribute_names
    f.object.user = Doctor.new if f.object.user.nil?

    f.inputs 'Profile details' do
      f.input :user_type, input_html: { value: 'Doctor' }, as: :hidden
      f.input :email
      f.input :phone_number
      f.input :password if f.object.new_record?
      f.input :password_confirmation if f.object.new_record?
    end

    f.inputs 'Doctor details' do
      f.has_many :user, heading: false, new_record: false do |user_f|
        user_f.input :category
        user_f.input :first_name
        user_f.input :last_name
        user_f.input :education
      end
    end

    f.actions
  end

  index do
    selectable_column
    column :email
    column :phone_number
    column :first_name do |resource|
      resource.user.first_name
    end
    column :last_name do |resource|
      resource.user.last_name
    end
    column :category do |resource|
      resource.user.category
    end
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table_for resource.user do
      row :first_name
      row :last_name
      row :category
      row :education
      row :created_at
      row :updated_at
    end
  end

  sidebar 'Profile details', only: :show do
    attributes_table do
      row :email
      row :phone_number
    end
  end

  controller do
    def scoped_collection
      end_of_association_chain.doctors
    end
  end
end
