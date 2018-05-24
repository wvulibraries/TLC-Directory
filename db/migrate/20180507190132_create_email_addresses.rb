class CreateEmailAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :email_addresses do |t|
      t.belongs_to :user, index: true
      t.string :email

      t.timestamps
    end
  end
end
