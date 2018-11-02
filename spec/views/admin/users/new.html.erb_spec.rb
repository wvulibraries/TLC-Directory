require 'rails_helper'

RSpec.describe "admin/users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      wvu_username: Faker::Internet.user_name,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: "#{Faker::Internet.user_name(7..36)}@mail.wvu.edu",
      status: :disabled,
      role: :user,
      visible: false
    ))
  end


  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input[name=?]", "user[wvu_username]"

      assert_select "input[name=?]", "user[last_name]"

      assert_select "input[name=?]", "user[first_name]"

      assert_select "select[name=?]", "user[status]"

      assert_select "select[name=?]", "user[role]"

      assert_select "input[name=?]", "user[visible]"
    end
  end
end
