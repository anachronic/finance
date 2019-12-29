require 'rails_helper'

RSpec.describe Account, type: :model do
  it 'Validates presence of name' do
    user = FactoryBot.create(:user)

    expect {
      Account.create!(user: user)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'Belongs to an user' do
    user = FactoryBot.create(:user)
    account = FactoryBot.create(:account, user: user)

    db_account = Account.first
    expect(db_account.user.id).to eq(user.id)
  end
end
