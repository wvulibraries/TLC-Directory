# frozen_string_literal: true

class CreateColleges < ActiveRecord::Migration[5.2]
  def change
    create_table :colleges do |t|
      t.string :name
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
