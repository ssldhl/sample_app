class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.string :name
      t.date :dob
      t.text :address
      t.integer :user_id

      t.timestamps
    end
    add_index :forms, [:user_id, :created_at]
  end
end
