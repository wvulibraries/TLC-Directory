require 'rails_helper'

RSpec.describe "admin/email_addresses/edit", type: :view do
  before(:each) do
    @user = FactoryBot.create(:user)
    @email_address = FactoryBot.create(:email_address, user: @user)

    # @email_address = assign(:email_address, EmailAddress.create!())
  end

  it "renders the edit email_address form" do
    render

    assert_select "form[action=?][method=?]", email_address_path(@email_address), "post" do
    end
  end
end
