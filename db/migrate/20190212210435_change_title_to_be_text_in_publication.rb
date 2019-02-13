class ChangeTitleToBeTextInPublication < ActiveRecord::Migration[5.2]
  def change
          change_column :publications, :title, :text    
  end
end
