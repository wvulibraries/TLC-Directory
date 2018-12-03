class RemoveFacultyFromUsers < ActiveRecord::Migration[5.2]
    remove_column :users, :title, :string
    remove_column :users, :biography, :text
    remove_column :users, :research_interests, :string
    remove_column :users, :image, :string
    remove_column :users, :resume, :string
end
