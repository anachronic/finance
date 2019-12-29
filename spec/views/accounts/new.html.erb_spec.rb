require 'rails_helper'

RSpec.describe "accounts/new", type: :view do
  before(:each) do
    assign(:account, Account.new)
  end

  # skip writing tests for redirection as they should be handled by the
  # controller

  it "renders new account form" do
    render

    assert_select "form[action=?][method=?]", accounts_path, "post" do
      assert_select "input[name=?]", "account[name]"
    end
  end

end
