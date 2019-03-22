# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Directory::Departments', type: :feature do
  # vars for existing
  let(:department) { FactoryBot.create(:department) }
  let(:department_two) { FactoryBot.create(:department) }
  let(:faculty) { FactoryBot.create(:faculty, department: department) }

  before(:each) do
    # instantiate creations so that each page can see them
    department
    department_two
    faculty
  end

  scenario 'departments index page' do
    visit '/directory/departments'
    expect(page).to have_content('Departments')
    expect(page).to have_content(department.name)
    expect(page).to have_content(department_two.name)
  end

  scenario 'department details' do
    visit "/directory/departments/#{department.id}"
    expect(page).to have_content(department.name)
  end

  scenario 'department faculties' do
    visit "/directory/departments/#{department.id}/faculties"
    expect(page).to have_content(department.name)
    expect(page).to have_content(faculty.display_name)
    expect(page).to have_content(faculty.email)
  end
end
