class CreateAwards < ActiveRecord::Migration[5.2]
  def change
    create_table :awards do |t|
      t.references :awardable, polymorphic: true, index: true
      t.integer :starting_year
      t.integer :ending_year
      t.string :description
      
      t.timestamps
    end
  end
end
