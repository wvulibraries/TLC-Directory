class CreatePublications < ActiveRecord::Migration[5.2]
  def change
    create_table :publications do |t|
      t.belongs_to :user, index: true
      t.string :description
      t.timestamps
    end
  end
end
