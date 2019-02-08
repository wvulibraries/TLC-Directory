class ChangeTeachingInterestsToBeTextInFaculty < ActiveRecord::Migration[5.2]
  def change
      change_column :faculty, :teaching_interests, :text
  end
end
