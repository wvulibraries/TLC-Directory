# frozen_string_literal: true

class CreateDepartments < ActiveRecord::Migration[5.2]
  def change
    create_table :departments do |t|
      t.string :name
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
