class AddTeachingInterestsToFaculty < ActiveRecord::Migration[5.2]
  def change
    add_column :faculty, :teaching_interests, :string
  end
end
