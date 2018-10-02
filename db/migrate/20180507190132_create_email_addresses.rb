class CreateEmailAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :email_addresses do |t|
      t.references :emailable, polymorphic: true, index: true
      t.string :email_address

      t.timestamps
    end
  end
end
