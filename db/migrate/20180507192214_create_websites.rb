class CreateWebsites < ActiveRecord::Migration[5.2]
  def change
    create_table :websites do |t|
      t.integer :user_id
      t.string :website_url

      t.timestamps
    end
    add_index :websites, :user_id
  end
end
