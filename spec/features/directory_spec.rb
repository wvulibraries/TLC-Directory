require 'rails_helper'

RSpec.feature "Directory", type: :feature do
   # vars for existing 
  let(:college) { FactoryBot.create(:college) }
  let(:department) { FactoryBot.create(:department) }

  # show a faculty that is set to visible and enabled
  let(:faculty) { FactoryBot.create(:faculty, college: college, department: department) }


  before(:each) do
    # instantiate creations so that each page can see them 
    college
    department
    faculty
    Faculty.__elasticsearch__.refresh_index!
  end

  scenario 'directory list index' do
    visit '/directory'
    expect(page).to have_content(faculty.display_name)
    # expect(page).to have_content(department.name)
    # expect(page).to have_content(college.name)
  end
  
  scenario 'directory search' do
    visit "/"
    fill_in 'search', with: faculty.first_name
    find('[name=submit]').click    
    expect(page).to have_content(faculty.display_name)
    # expect(page).to have_content(department.name)
    # expect(page).to have_content(college.name)
  end 

  scenario 'directory refine search college' do
    visit "/directory"
    fill_in 'search', with: faculty.first_name
    select college.name, :from => "college"  
    click_button "submit"    
    expect(page).to have_content(faculty.display_name)
    expect(page).to have_content(college.name)
  end 

  scenario 'directory refine search department' do
    visit "/directory"
    fill_in 'search', with: faculty.first_name
    select department.name, :from => "department"   
    click_button "submit"    
    expect(page).to have_content(faculty.display_name)
    expect(page).to have_content(department.name)
  end 

  scenario 'directory refine search college & department' do
    visit "/directory"
    fill_in 'search', with: faculty.first_name
    select college.name, :from => "college"
    select department.name, :from => "department"   
    click_button "submit"    
    expect(page).to have_content(faculty.display_name)
    expect(page).to have_content(department.name)
    expect(page).to have_content(college.name)
  end 

  scenario 'directory profile' do
    visit "/directory/faculties/#{faculty.id}"
    expect(page).to have_content(faculty.display_name)
    expect(page).to have_content(faculty.title)
    expect(page).to have_content(faculty.email)
    # expect(page).to have_content(department.name)
    # expect(page).to have_content(college.name)
  end
end