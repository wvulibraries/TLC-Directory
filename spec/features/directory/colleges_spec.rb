require 'rails_helper'

RSpec.feature "Directory::Colleges", type: :feature do
  # vars for existing
  let(:college) { FactoryBot.create(:college) }
  let(:college_two) { FactoryBot.create(:college) }
  let(:faculty) { FactoryBot.create(:faculty, colleges: [college]) }

  before(:each) do
    # instantiate creations so that each page can see them
    college
    college_two
    faculty
  end

  scenario 'colleges index page' do
    visit '/directory/colleges'
    expect(page).to have_content('Colleges')
    expect(page).to have_content(college.name)
    expect(page).to have_content(college_two.name)
  end

  scenario 'college details' do
    visit "/directory/colleges/#{college.id}"
    expect(page).to have_content(college.name)
  end

  scenario 'college faculties' do
    visit "/directory/colleges/#{college.id}/faculties"
    expect(page).to have_content(college.name)
    expect(page).to have_content(faculty.display_name)
    expect(page).to have_content(faculty.email)
  end
end