class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_enum :appointment_status, %w[planned completed]

    create_table :appointments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :doctor, null: false, foreign_key: true
      t.enum :status, enum_type: :appointment_status, default: :planned, null: false
      t.text :prescription

      t.timestamps
    end
  end
end
