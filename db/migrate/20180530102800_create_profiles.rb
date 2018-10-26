class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.belongs_to :user, index: true
      t.string :college
      t.string :department
      t.string :title
      t.text :biography
      t.text :research_interests
      t.timestamps
    end
  end
end
