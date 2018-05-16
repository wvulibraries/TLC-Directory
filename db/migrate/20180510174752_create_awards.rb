class CreateAwards < ActiveRecord::Migration[5.2]
  def change
    create_table :awards do |t|
      t.integer :user_id
      t.string :starting_year
      t.string :ending_year
      t.string :description
      t.timestamps
    end
    add_index :awards, :user_id
  end
end
