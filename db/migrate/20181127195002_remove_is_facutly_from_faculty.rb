class RemoveIsFacutlyFromFaculty < ActiveRecord::Migration[5.2]
  def change
    remove_column :faculty, :isFaculty, :boolean
  end
end
