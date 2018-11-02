# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create Users
User.create(wvu_username: 'djdavis', first_name: 'David', last_name: 'Davis', role: :admin, status: :active, visible: false)
User.create(wvu_username: 'tam0013', first_name: 'Tracy', last_name: 'McCormick', role: :admin, status: :active, visible: false)

# Department.create(name: 'Department of English')
# Department.create(name: 'WVU Libraries')
# Department.create(name: 'Department of Communication Studies')
# Department.create(name: 'School of Social Work')
# Department.create(name: 'Department of Learning Sciences and Human Development')
# Department.create(name: 'Department of Pharmaceutical Sciences')
# Department.create(name: 'Department of Physics and Astronomy')
# Department.create(name: 'C. Eugene Bennett Department of Chemistry')
# Department.create(name: 'Department of Biology')
# 
# 
# College.create(name: 'Eberly College of Arts and Sciences')
# College.create(name: 'College of Education and Human Services')
# College.create(name: 'College of Physical Activity and Sport Sciences')
# College.create(name: 'Reed College of Media')
# College.create(name: 'Statler College of Engineering and Mineral Resources')
# College.create(name: 'School of Pharmacy')
# College.create(name: 'College of Business & Economics')
# College.create(name: 'College of Law')


