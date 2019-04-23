# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Admin::Departments', type: :feature do
  let(:department) { FactoryBot.create(:department) }
  let(:new_department) { FactoryBot.attributes_for(:department) }

  before(:each) do
    department
  end

  scenario 'department index page and it works properly' do
    visit '/admin/departments'
    expect(page).to have_content('Manage Departments')
  end

  scenario 'creates a new department' do
    visit '/admin/departments/new'
    fill_in 'Name', with: new_department[:name]
    click_button 'Submit'
    expect(page).to have_content('Success! New Department was created!')
  end

  scenario 'errors on creating a new department' do
    visit '/admin/departments/new'
    fill_in 'Name', with: 'tes' # must be 5 chars
    select('enabled', from: 'Department Status')
    click_button 'Submit'
    expect(page).to have_content('Name is too short (minimum is 5 characters)')
  end

  scenario 'user clicks the cancel button goes back to the departments list' do
    visit '/admin/departments/new'
    click_link 'Cancel'
    expect(current_path).to eq('/admin/departments')
    expect(page).to have_content('Manage Departments')
  end

  scenario 'updates an existing department' do
    visit "/admin/departments/#{department.id}/edit"
    fill_in 'Name', with: 'Changing the Name'
    click_button 'Submit'
    expect(page).to have_content('Success! We have edited the department!')
  end

  scenario 'errors on editing a department' do
    visit "/admin/departments/#{department.id}/edit"
    fill_in 'Name', with: 'tes' # must be 5 chars
    click_button 'Submit'
    expect(page).to have_content('The following prohibited this department from being saved:')
    expect(page).to have_content('Name is too short (minimum is 5 characters)')
  end

  scenario 'deletes an existing department' do
    visit '/admin/departments'
    click_link 'Destroy'
    expect(page).to have_content('Manage Departments')
    expect(page).to have_content('Department Removed! The department was removed, for temporary removal you should change the department status.')
    expect(page).to_not have_content(department.name)
  end
end
