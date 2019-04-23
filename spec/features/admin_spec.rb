# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Admin', type: :feature do

  scenario 'list index' do
    visit '/admin'
    expect(page).to have_content('TLC Directory :: Admin Panel')
  end
end
