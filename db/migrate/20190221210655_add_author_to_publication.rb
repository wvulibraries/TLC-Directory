class AddAuthorToPublication < ActiveRecord::Migration[5.2]
  def change
    add_column :publications, :author, :text
  end
end
