class AddFacultyInfoToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :college, :string
    add_column :users, :department, :string
    add_column :users, :title, :string
    add_column :users, :biography, :text
    add_column :users, :research_interests, :string
    add_column :users, :image, :string
    add_column :users, :resume, :string
  end
end
