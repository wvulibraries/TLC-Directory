class CreateFacultyTable < ActiveRecord::Migration[5.2]
  def change
    create_table :faculty do |t|
      t.string :preferred_name
      t.string :prefix
      t.string :last_name
      t.string :first_name
      t.string :middle_name
      t.string :suffix
      t.string :email
      t.string :wvu_username, limit: 30      
      t.integer :role, default: :user
      t.integer :status, default: :disabled
      t.boolean :visible, default: false
      t.string :title
      t.text :biography
      t.string :research_interests
      t.string :image
      t.string :resume
          
      t.timestamps
    end
  end
end