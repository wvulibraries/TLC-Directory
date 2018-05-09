class CreatePhones < ActiveRecord::Migration[5.2]
  def change
    create_table :phones do |t|
      t.integer :user_id
      t.string :phone_number
      t.string :type

      t.timestamps
    end
    add_index :phones, :user_id
  end
end
