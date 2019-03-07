class CreatePublications < ActiveRecord::Migration[5.2]
  def change
    create_table :publications do |t|
      t.references :publishable, polymorphic: true, index: true
      t.text :description
      t.string :status
      t.string :publisher
      t.string :pagenum
      t.integer :issue
      t.integer :volume
      t.timestamps
    end
  end
end
