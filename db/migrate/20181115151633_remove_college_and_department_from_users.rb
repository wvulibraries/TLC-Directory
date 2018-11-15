class RemoveCollegeAndDepartmentFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :college, :string
    remove_column :users, :department, :string
  end
end
