class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.attachment :document
      t.references :documentable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
