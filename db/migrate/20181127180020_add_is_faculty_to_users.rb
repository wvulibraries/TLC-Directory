class AddIsFacultyToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :isFaculty, :boolean
  end
end
