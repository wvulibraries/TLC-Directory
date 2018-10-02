class CreateWebsites < ActiveRecord::Migration[5.2]
  def change
    create_table :websites do |t|
      t.references :webable, polymorphic: true, index: true
      t.string :website_url

      t.timestamps
    end
  end
end
