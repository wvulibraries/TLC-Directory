require 'rails_helper'

RSpec.describe "admin/email_addresses/new", type: :view do
  before(:each) do
    assign(:email_address, EmailAddress.new())
  end

  it "renders new email_address form" do
    render

    assert_select "form[action=?][method=?]", email_addresses_path, "post" do
    end
  end
end
