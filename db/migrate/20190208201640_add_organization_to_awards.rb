# frozen_string_literal: true

class AddOrganizationToAwards < ActiveRecord::Migration[5.2]
  def change
    add_column :awards, :organization, :string
  end
end
