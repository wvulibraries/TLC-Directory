class CreateWebsites < ActiveRecord::Migration[5.2]
  def change
    create_table :websites do |t|
      t.belongs_to :user, index: true
      t.string :website_url

      t.timestamps
    end
  end
end
