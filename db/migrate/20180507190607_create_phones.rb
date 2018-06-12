class CreatePhones < ActiveRecord::Migration[5.2]
  def change
    create_table :phones do |t|
      t.belongs_to :user, index: true
      t.string :phone_number
      t.string :phone_type

      t.timestamps
    end
  end
end
