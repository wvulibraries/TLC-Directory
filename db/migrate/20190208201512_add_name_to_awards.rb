# frozen_string_literal: true

class AddNameToAwards < ActiveRecord::Migration[5.2]
  def change
    add_column :awards, :name, :string
  end
end
