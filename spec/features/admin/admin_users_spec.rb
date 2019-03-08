require 'rails_helper'

RSpec.feature "Admin::User", type: :feature do
  let(:user_existing) { FactoryBot.create(:user) }
  let(:user) { FactoryBot.attributes_for(:user) }

  before(:each) do
    user_existing
  end

  scenario 'testing the index page for users and returning proper information' do
    visit '/admin/users'
    expect(page).to have_content('Manage User(s)')
  end 

  scenario 'creates a new user' do
    visit '/admin/users/new'
    select('Mr', from: 'Prefix')
    fill_in 'First name', with: user[:first_name]
    fill_in 'Middle name', with: user[:middle_name]
    fill_in 'Last name', with: user[:last_name]
    select('I', from: 'Suffix')
    fill_in 'Wvu username', with: user[:wvu_username]
    fill_in 'Email', with: user[:email]
    select('user', from: 'User Role')
    select('enabled', from: 'User Status')
    click_button 'Submit'
    expect(page).to have_content(I18n.t('user.success'))
  end

  scenario 'fails creating a new user because of no wvu username' do
    visit '/admin/users/new'
    select('Mr', from: 'Prefix')
    fill_in 'First name', with: user[:first_name]
    fill_in 'Middle name', with: user[:middle_name]
    fill_in 'Last name', with: user[:last_name]
    select('I', from: 'Suffix')
    fill_in 'Wvu username', with: ''
    fill_in 'Email', with: user[:email]
    select('user', from: 'User Role')
    select('enabled', from: 'User Status')
    click_button 'Submit'
    expect(page).to have_content('Wvu username can\'t be blank')
    expect(page).to have_content('Wvu username is too short (minimum is 4 characters)')
  end

  scenario 'updates an existing user' do
    visit "/admin/users/#{user_existing.id}/edit"
    fill_in 'First name', with: 'Gimli'
    click_button 'Submit'
    expect(page).to have_content(I18n.t('user.edited'))
  end

  scenario 'fails updating an existing user' do
    visit "/admin/users/#{user_existing.id}/edit"
    fill_in 'First name', with: 'G'
    click_button 'Submit'
    expect(page).to have_content('First name is too short (minimum is 2 characters)')
  end

  scenario 'deletes an existing user' do
    # then visit destroy path
    visit '/admin/users'
    click_link 'Delete'
    expect(page).to have_content('Manage User')
    expect(page).to have_content(I18n.t('user.deleted'))
    expect(page).to_not have_content(user_existing.first_name)
  end
end