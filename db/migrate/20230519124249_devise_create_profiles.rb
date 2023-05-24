# frozen_string_literal: true

class DeviseCreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :phone_number,       null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      t.timestamps null: false
    end

    add_index :profiles, :email,                unique: true
    add_index :profiles, :phone_number,         unique: true
    add_index :profiles, :reset_password_token, unique: true
  end
end
