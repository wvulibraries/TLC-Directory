class CreateAwards < ActiveRecord::Migration[5.2]
  def change
    create_table :awards do |t|
      t.belongs_to :user, index: true
      t.string :starting_year
      t.string :ending_year
      t.string :description
      t.timestamps
    end
  end
end
