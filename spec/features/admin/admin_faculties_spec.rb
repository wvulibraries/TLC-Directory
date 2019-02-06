require 'rails_helper'

RSpec.feature "Admin::Faculty", type: :feature do
  # vars for existing 
  let(:college) { FactoryBot.create(:college) }
  let(:department) { FactoryBot.create(:department) }
  let(:faculty_existing) { FactoryBot.create(:faculty) }
  # vars for creating 
  # let(:address) { FactoryBot.attributes_for(:address) }
  # let(:phone) { FactoryBot.attributes_for(:phone) }
  let(:faculty) { FactoryBot.attributes_for(:faculty) }

  before(:each) do
    college
    department
    faculty_existing
  end

  scenario 'testing the index page for faculties and returning proper information' do
    visit '/admin/faculties'
    expect(page).to have_content('Manage Faculty')
  end 

  scenario 'creates a new faculty' do
    visit '/admin/faculties/new'
    select('Mr', from: 'Prefix')
    fill_in 'First name', with: faculty[:first_name]
    fill_in 'Middle name', with: faculty[:middle_name]
    fill_in 'Last name', with: faculty[:last_name]
    select('I', from: 'Suffix')
    fill_in 'Wvu username', with: faculty[:wvu_username]
    fill_in 'Email', with: faculty[:email]
    fill_in 'Title', with: faculty[:title]
    fill_in 'Biography', with: faculty[:biography]
    fill_in 'Research interests', with: faculty[:research_interests]    
    select('user', from: 'User Role')
    select('enabled', from: 'User Status')
    click_button 'Submit'
    expect(page).to have_content('Success! Faculty profile was created!')
  end

  scenario 'fails creating a new faculty because of no wvu username' do
    visit '/admin/faculties/new'
    select('Mr', from: 'Prefix')
    fill_in 'First name', with: faculty[:first_name]
    fill_in 'Middle name', with: faculty[:middle_name]
    fill_in 'Last name', with: faculty[:last_name]
    select('I', from: 'Suffix')
    fill_in 'Wvu username', with: ''
    fill_in 'Email', with: faculty[:email]
    fill_in 'Title', with: faculty[:title]
    fill_in 'Biography', with: faculty[:biography]
    fill_in 'Research interests', with: faculty[:research_interests]
    select('user', from: 'User Role')
    select('enabled', from: 'User Status')
    click_button 'Submit'
    expect(page).to have_content('Wvu username can\'t be blank')
    expect(page).to have_content('Wvu username is too short (minimum is 4 characters)')
  end

  scenario 'updates an existing faculty' do
    visit "/admin/faculties/#{faculty_existing.id}/edit"
    fill_in 'First name', with: 'Gimli'
    click_button 'Submit'
    expect(page).to have_content('Success! Faculty profile was edited.')
  end

  scenario 'fails updating an existing faculty' do
    visit "/admin/faculties/#{faculty_existing.id}/edit"
    fill_in 'First name', with: 'G'
    click_button 'Submit'
    expect(page).to have_content('First name is too short (minimum is 2 characters)')
  end

  # scenario 'add Address' do
  #   visit "/admin/faculties/#{faculty_existing.id}/edit"
  #   click_on 'Add Address'
  #   fill_in 'City', with: 'Morgantown'
  #   click_button 'Submit'
  #   expect(page).to have_content('Success! Faculty profile was edited.')   
  # end


  scenario 'deletes an existing faculty' do
    # then visit destroy path
    visit '/admin/faculties'
    click_link 'Delete'
    expect(page).to have_content('Manage Faculty')
    expect(page).to have_content('Faculty Removed! The faculty profile was removed, for temporary removal you should change the faculty status.')
    expect(page).to_not have_content(faculty_existing.first_name)
  end
end