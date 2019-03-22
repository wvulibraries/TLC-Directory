# frozen_string_literal: true

class CreateSearchTerms < ActiveRecord::Migration[5.2]
  def change
    create_table :search_terms do |t|
      t.string :term
      t.string :yearmonth
      t.integer :term_count

      t.timestamps
    end
  end
end
