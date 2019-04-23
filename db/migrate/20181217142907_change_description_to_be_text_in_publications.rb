# frozen_string_literal: true

class ChangeDescriptionToBeTextInPublications < ActiveRecord::Migration[5.2]
  def change
    change_column :publications, :description, :text
  end
end
