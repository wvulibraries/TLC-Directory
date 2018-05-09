class CreateEmailAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :email_addresses do |t|
      t.integer :user_id
      t.string :email

      t.timestamps
    end
    add_index :email_addresses, :user_id
  end
end
