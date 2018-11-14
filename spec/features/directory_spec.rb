require 'rails_helper'

RSpec.feature "Directory", type: :feature do
  # vars for existing
  # let(:building) { FactoryBot.create(:building_seed) }
  # let(:building_complete) { FactoryBot.create(:building_seed_complete, name: 'Jumping Joes Crab Shack') }
  # let(:department) { FactoryBot.create(:department_seed, building: building) }
  # let(:department_two) { FactoryBot.create(:department_seed, building: building) }
  #let(:faculty) { FactoryBot.create(:faculty_seed, departments: [department, department_two]) }
  
  # show a faculty that is set to visible and enabled
  let(:faculty) { FactoryBot.create(:faculty_visible) }

  before(:each) do
    # instantiate creations so that each page can see them 
    # building
    # department
    # department_two
    faculty
  end

  scenario 'directory list index' do
    visit '/directory'
    expect(page).to have_content(faculty.display_name)
    # expect(page).to have_content(department.name)
  end

  scenario 'directory profile' do
    visit "/directory/#{faculty.id}"
    expect(page).to have_content(faculty.display_name)
    expect(page).to have_content(faculty.title)
    # expect(page).to have_content(faculty.university_classification)
    expect(page).to have_content(faculty.email)
    # expect(page).to have_content(department.name)
  end
end