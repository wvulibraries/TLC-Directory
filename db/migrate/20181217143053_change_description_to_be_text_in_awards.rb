class ChangeDescriptionToBeTextInAwards < ActiveRecord::Migration[5.2]
  def change
      change_column :awards, :description, :text
  end
end
