# frozen_string_literal: true

class ChangeResearchInterestsToBeTextInFaculty < ActiveRecord::Migration[5.2]
  def change
    change_column :faculty, :research_interests, :text
  end
end
