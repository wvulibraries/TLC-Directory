require 'rails_helper'

RSpec.describe "admin/faculties/new", type: :view do
  before(:each) do
    assign(:faculty, Faculty.new(
      wvu_username: Faker::Internet.user_name,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: "#{Faker::Internet.user_name(7..36)}@mail.wvu.edu",
      status: :disabled,
      role: :user,
      visible: false
    ))
  end


  it "renders new faculty form" do
    render

    assert_select "form[action=?][method=?]", faculties_path, "post" do

      assert_select "input[name=?]", "faculty[wvu_username]"

      assert_select "input[name=?]", "faculty[last_name]"

      assert_select "input[name=?]", "faculty[first_name]"

      assert_select "select[name=?]", "faculty[status]"

      assert_select "select[name=?]", "faculty[role]"

      assert_select "input[name=?]", "faculty[visible]"
    end
  end
end
