class AddTagsToFaculty < ActiveRecord::Migration[5.2]
  def change
    add_column :faculty, :tags, :string
  end
end
