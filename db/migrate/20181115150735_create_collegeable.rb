class CreateCollegeable < ActiveRecord::Migration[5.2]
  def change
    create_table :collegeables do |t|
      t.belongs_to :faculty, index: true
      t.belongs_to :college, index: true
      
      t.timestamps
    end
  end
end
