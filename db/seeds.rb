# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create Users
User.create(wvu_username: 'djdavis', first_name: 'David', last_name: 'Davis', email: 'djdavis@mail.wvu.edu', role: :admin, status: 'enabled', visible: false)
User.create(wvu_username: 'tam0013', first_name: 'Tracy', last_name: 'McCormick', email: 'tam0013@mail.wvu.edu', role: :admin, status: 'enabled', visible: false)

dept = Department.create(name: 'Department of English', status: :enabled)
dept1 = Department.create(name: 'WVU Libraries', status: :enabled)
Department.create(name: 'Department of Communication Studies', status: :enabled)
Department.create(name: 'School of Social Work', status: :enabled)
Department.create(name: 'Department of Learning Sciences and Human Development', status: :enabled)
Department.create(name: 'Department of Pharmaceutical Sciences', status: :enabled)
Department.create(name: 'Department of Physics and Astronomy', status: :enabled)
Department.create(name: 'C. Eugene Bennett Department of Chemistry', status: :enabled)
Department.create(name: 'Department of Biology', status: :enabled)

# Create College's
college = College.create(name: 'Eberly College of Arts and Sciences', status: :enabled)
college1 = College.create(name: 'College of Education and Human Services', status: :enabled)
College.create(name: 'College of Physical Activity and Sport Sciences', status: :enabled)
College.create(name: 'Reed College of Media', status: :enabled)
College.create(name: 'Statler College of Engineering and Mineral Resources', status: :enabled)
College.create(name: 'School of Pharmacy', status: :enabled)
College.create(name: 'College of Business & Economics', status: :enabled)
College.create(name: 'College of Law', status: :enabled)

# Create Faculty
40.times do
   FactoryBot.create(:faculty, department: dept, college: college)
end

40.times do
   FactoryBot.create(:faculty, department: dept1, college: college1)
end
