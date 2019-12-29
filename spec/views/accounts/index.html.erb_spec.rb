require 'rails_helper'

RSpec.describe "accounts/index", type: :view do
  before(:each) do
    user = FactoryBot.create(:user)
    accounts = [
      FactoryBot.create(:account, user: user),
      FactoryBot.create(:account, user: user)
    ]
    assign(:accounts, accounts)
  end

  it "renders a list of accounts" do
    render

    assert_select "th", text: /Account/i, count: 1
    assert_select "tbody>tr", count: 2
  end
end
