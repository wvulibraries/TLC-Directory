require 'rails_helper'

RSpec.describe "admin/email_addresses/show", type: :view do
  before(:each) do
    @user = FactoryBot.create(:user)
    @email_address = FactoryBot.create(:email_address, user: @user)
  end

  it "renders attributes in <p>" do
    render
  end
end
