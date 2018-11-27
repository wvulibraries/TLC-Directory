class CreateFacultyTable < ActiveRecord::Migration[5.2]
  def change
   execute "create table faculty select * from users where 1=0"
  end
end
