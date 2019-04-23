# frozen_string_literal: true

class AddResumeYearToFaculty < ActiveRecord::Migration[5.2]
  def change
    add_column :faculty, :resume_year, :string
  end
end
