require 'rails_helper'

RSpec.describe "accounts/show", type: :view do
  before(:each) do
    @account = assign(:account, FactoryBot.create(:account))
  end

  it "renders the account name and owner email" do
    render
    expect(rendered).to match(/#{@account.name}/)
    expect(rendered).to match(/#{@account.user.email}/)
  end
end
