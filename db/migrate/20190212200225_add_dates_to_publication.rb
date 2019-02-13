class AddDatesToPublication < ActiveRecord::Migration[5.2]
  def change
    add_column :publications, :starting_year, :integer
    add_column :publications, :ending_year, :integer
  end
end
