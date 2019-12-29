require 'rails_helper'

RSpec.describe User, type: :model do
  it 'Creates ok with user, password and password confirmation' do
    expect {
      FactoryBot.create(:user)
    }.to_not raise_error
  end

  it 'Has many Accounts' do
    user = FactoryBot.create(:user)
    acc1 = FactoryBot.create(:account, user: user)
    acc2 = FactoryBot.create(:account, user: user)

    accounts = user.accounts
    accounts.each do |acc|
      expect(acc.user.id).to eq(user.id)
    end
  end
end
