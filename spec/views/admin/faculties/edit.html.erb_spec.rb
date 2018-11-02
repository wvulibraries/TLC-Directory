require 'rails_helper'

RSpec.describe "admin/faculties/edit", type: :view do
  before(:each) do
    @faculty = FactoryBot.create(:faculty)
  end

  it "renders the edit faculty form" do
    render

    assert_select "form[action=?][method=?]", faculty_path(@faculty), "post" do

      assert_select "input[name=?]", "faculty[wvu_username]"

      assert_select "input[name=?]", "faculty[last_name]"

      assert_select "input[name=?]", "faculty[first_name]"

      assert_select "input[name=?]", "faculty[middle_name]"
    end
  end
end
