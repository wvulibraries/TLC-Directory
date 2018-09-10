require 'rails_helper'

RSpec.describe "admin/users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        wvu_username: 'Username',
        last_name: 'Last Name',
        first_name: 'First Name',
        role: :user,
        visible: false,
        status: :disabled
      )
    ])
  end

  it 'renders a list of users' do
    render
    assert_select 'tr>td', text: 'Username'.to_s, count: 1
    assert_select 'tr>td', text: 'Last Name'.to_s, count: 1
    assert_select 'tr>td', text: 'First Name'.to_s, count: 1
  end
end
