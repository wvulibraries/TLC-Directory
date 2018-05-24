class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.belongs_to :user, index: true
      t.integer :user_id
      t.text :bio

      t.timestamps
    end
  end
end
