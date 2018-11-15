require 'rails_helper'

RSpec.feature 'Admin::Colleges', type: :feature do
  let(:college) { FactoryBot.create(:college) }
  let(:new_college) { FactoryBot.attributes_for(:college) }

  scenario 'college index page and it works properly' do
    visit '/admin/colleges'
    expect(page).to have_content('Manage Colleges')
  end

  scenario 'creates a new college' do
    visit '/admin/colleges/new'
    fill_in 'Name', with: new_college[:name]
    click_button 'Submit'
    expect(page).to have_content('Success! New College was created!')
  end

  scenario 'errors on creating a new college' do
    visit '/admin/colleges/new'
    fill_in 'Name', with: 'tes' # must be 4 chars
    click_button 'Submit'
    expect(page).to have_content('Name is too short (minimum is 4 characters)')
  end

  scenario 'updates an existing college' do
    visit "/admin/colleges/#{college.id}/edit"
    fill_in 'Name', with: 'Changing the Name'
    click_button 'Submit'
    expect(page).to have_content('Success! College was edited.')
  end

  scenario 'errors on creating editing college' do
    college = FactoryBot.create(:college)
    college.save!
    visit "/admin/colleges/#{college.id}/edit"
    fill_in 'Name', with: 'tes' # must be 4 chars
    click_button 'Submit'
    expect(page).to have_content('Name is too short (minimum is 4 characters)')
  end

  scenario 'deletes an existing college' do
    college = FactoryBot.create(:college)
    college.save!
    visit '/admin/colleges'
    click_link 'Destroy'
    expect(page).to have_content('Manage Colleges')
    expect(page).to have_content('College Removed! The college was removed, for temporary removal you should change the college status.')
    expect(page).to_not have_content(college.name)
  end
end
