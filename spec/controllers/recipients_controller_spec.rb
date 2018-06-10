require 'rails_helper'
RSpec.describe RecipientsController, type: :controller do
  let(:current_user) { create(:user) }
  let(:valid_session) { { user_id: current_user.id } }
  let(:token) { 'token' }
  let(:recipients) do
    [
      {
        'name' => 'Rec1',
        'id' => 'Id1'
      },
      {
        'name' => 'Rec2',
        'id' => 'Id2'
      }
    ]
  end

  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  before do
    create(:credential, user_id: current_user.id)
    allow(Api::Coolpay::Authentication).to receive(:login).and_return('token' => token)
    allow(Api::Coolpay::Models::Recipient).to receive(:all).with(token).and_return(recipients)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}, session: valid_session
      expect(response).to be_success
    end
  end
end
