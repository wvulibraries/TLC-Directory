require 'rails_helper'

RSpec.feature "Admin::Searchstats", type: :feature do
  # vars for existing 
  let(:faculty) { FactoryBot.create(:faculty) }  

  before(:each) do
      faculty
  end

  scenario 'search random number of times and verify that stats matches count' do
    loop_number = rand(1..10)
    loop_number.times do
      visit "/"
      fill_in 'search', with: faculty.first_name
      find('[name=submit]').click    
      expect(page).to have_content(faculty.display_name)
    end

    #verify that searchstats are correct
    visit "/admin/searchstats"
    expect(page).to have_content(faculty.first_name)
    expect(page).to have_content(loop_number)
  end  

end