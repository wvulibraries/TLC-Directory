class CreatePhones < ActiveRecord::Migration[5.2]
  def change
    create_table :phones do |t|
      t.belongs_to :user, index: true
      t.string :number
      t.integer :number_types

      t.timestamps
    end
  end
end
