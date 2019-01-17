require 'rails_helper'

RSpec.feature "Admin::Searchstats", type: :feature do
  # vars for existing 
  let(:faculty) { FactoryBot.create(:faculty) }  

  before(:each) do
      faculty
  end

  scenario 'search twice and verify search term exists and count is 2' do
    visit "/"
    fill_in 'search', with: faculty[:last_name]
    find('[name=submit]').click

    visit "/"
    fill_in 'search', with: faculty[:last_name]
    find('[name=submit]').click

    visit '/admin/searchstats'
    expect(page).to have_content('Search Terms')
    expect(page).to have_content(faculty[:last_name])
    expect(page).to have_content(1)    
  end  

end