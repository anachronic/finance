require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  let(:valid_attributes) {
    { name: 'Just a name' }
  }

  let(:invalid_attributes) {
    { name: nil }
  }
  describe "GET #index" do
    it "returns a success response for a logged in user" do
      user = FactoryBot.create(:user)
      account1 = FactoryBot.create(:account, user: user)
      account2 = FactoryBot.create(:account, user: user)

      user.confirm
      sign_in user

      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'Redirects to login if no user is logged in' do
      user = FactoryBot.create(:user)
      account1 = FactoryBot.create(:account, user: user)
      account2 = FactoryBot.create(:account, user: user)
      
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET #show" do
    it "returns a success response for a logged in user" do
      account = FactoryBot.create(:account)

      account.user.confirm
      sign_in account.user

      get :show, params: {id: account.to_param}
      expect(response).to have_http_status(:ok)
    end

    it 'redirects to login if no user is logged in' do
      account = FactoryBot.create(:account)

      get :show, params: {id: account.to_param}
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET new" do
    it "returns a success response if user is logged in" do
      user = FactoryBot.create(:user)
      user.confirm
      sign_in user

      get :new
      expect(response).to be_successful
    end

    it "redirects to login if no user is logged in" do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      account = FactoryBot.create(:account)
      account.user.confirm
      sign_in account.user

      get :edit, params: {id: account.to_param}
      expect(response).to be_successful
    end

    it "redirects to login if no user is logged in" do
      account = FactoryBot.create(:account)
      get :edit, params: {id: account.to_param}
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "POST #create" do
    context "with valid params and a logged in user" do
      before(:each) do
        user = FactoryBot.create(:user)
        user.confirm
        sign_in user
      end

      it "creates a new Account" do
        expect {
          post :create, params: {account: valid_attributes}
        }.to change(Account, :count).by(1)
      end

      it "redirects to the created account" do
        post :create, params: {account: valid_attributes}
        expect(response).to redirect_to(Account.last)
      end
    end

    context "with invalid params for logged in user" do
      before(:each) do
        user = FactoryBot.create(:user)
        user.confirm
        sign_in user
      end

      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {account: invalid_attributes}
        expect(response).to be_successful
      end
    end

    context "without any user logged in" do
      it 'does not create a new account' do
        expect {
          post :create, params: {account: valid_attributes}
        }.to change(Account, :count).by(0)
      end

      it 'redirects to login screen' do
        post :create, params: {account: valid_attributes}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { name: 'A good name' }
      }

      before(:each) do
        user = FactoryBot.create(:user)
        user.confirm
        sign_in user
      end

      it "updates the requested account" do
        account = FactoryBot.create(:account)
        put :update, params: {id: account.to_param, account: new_attributes}
        account.reload
        expect(account.name).to eq('A good name')
      end

      it "redirects to the account" do
        account = FactoryBot.create(:account)
        put :update, params: {id: account.to_param, account: new_attributes}
        expect(response).to redirect_to(account)
      end
    end

    context "with invalid params for logged in user" do
      before(:each) do
        user = FactoryBot.create(:user)
        user.confirm
        sign_in user
      end

      it "returns a success response (i.e. to display the 'edit' template)" do
        account = FactoryBot.create(:account)
        put :update, params: {id: account.to_param, account: invalid_attributes}
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:edit)
      end
    end

    context "without any user logged in" do
      it "redirects to login screen" do
        account = FactoryBot.create(:account)
        put :update, params: {id: account.to_param, account: { name: 'changed' }}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "DELETE #destroy" do
    context "with a logged in user" do
      before(:each) do
        user = FactoryBot.create(:user)
        user.confirm
        sign_in user
      end

      it "destroys the requested account" do
        account = FactoryBot.create(:account)
        expect {
          delete :destroy, params: {id: account.to_param}
        }.to change(Account, :count).by(-1)
      end

      it "redirects to the accounts list" do
        account = FactoryBot.create(:account)
        delete :destroy, params: {id: account.to_param}
        expect(response).to redirect_to(accounts_url)
      end
    end

    context "without any logged in user" do
      it "redirects to login first without deleting" do
        account = FactoryBot.create(:account)
        expect {
          delete :destroy, params: {id: account.to_param}
        }.to change(Account, :count).by(0)

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end
