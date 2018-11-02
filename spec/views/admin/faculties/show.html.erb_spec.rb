require 'rails_helper'

RSpec.describe "admin/faculties/show", type: :view do
  before(:each) do
    @faculty = FactoryBot.create(:faculty)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Username/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/First Name/)
  end
end
