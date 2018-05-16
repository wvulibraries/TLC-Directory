require 'rails_helper'

RSpec.describe "admin/users/show", type: :view do
  before(:each) do
    @user = FactoryBot.create(:user)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Username/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/First Name/)
  end
end
