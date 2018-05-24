require 'rails_helper'

RSpec.describe "admin/email_addresses/index", type: :view do
  before(:each) do
    @user = FactoryBot.create(:user)
    assign(:email_addresses, [
      FactoryBot.create(:email_address, user: @user),
      FactoryBot.create(:email_address, user: @user)
    ])
  end

  it "renders a list of email_addresses" do
    render
  end
end
