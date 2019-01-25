class RemoveYearmonthFromSearchTerms < ActiveRecord::Migration[5.2]
  def change
    remove_column :search_terms, :yearmonth, :string
  end
end
