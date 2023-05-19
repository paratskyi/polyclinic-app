class AddReferenceToProfile < ActiveRecord::Migration[7.0]
  def change
    add_reference :profiles, :user, polymorphic: true, null: false, index: true
  end
end
