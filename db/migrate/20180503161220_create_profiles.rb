class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.text :bio

      t.timestamps
    end
    add_index :profiles, :user_id
  end
end
