require 'rails_helper'

RSpec.describe "admin/users/edit", type: :view do
  before(:each) do
    @user = FactoryBot.create(:user)
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do

      assert_select "input[name=?]", "user[wvu_username]"

      assert_select "input[name=?]", "user[last_name]"

      assert_select "input[name=?]", "user[first_name]"

      assert_select "input[name=?]", "user[middle_name]"
      
      assert_select "input[name=?]", "user[email]"
    end
  end
end
