require 'rails_helper'

RSpec.describe CredentialsController, type: :controller do
  let(:current_user) { create(:user) }
  let(:valid_session) { { user_id: current_user.id } }
  let(:valid_attributes) { attributes_for(:credential, user_id: current_user.id) }

  let(:invalid_attributes) do
    attributes_for(:credential, user: nil, username: nil, apikey: nil)
  end

  let(:invalid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      Credential.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      credential = Credential.create! valid_attributes
      get :show, params: { id: credential.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    context 'with not existsing credential' do
      it 'returns a success response' do
        get :new, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end

    context 'with existing credential' do
      it 'redirects back' do
        Credential.create! valid_attributes
        get :new, params: {}, session: valid_session
        expect(response).to redirect_to(:root)
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      credential = Credential.create! valid_attributes
      get :edit, params: { id: credential.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Credential' do
        expect do
          post :create, params: { credential: valid_attributes }, session: valid_session
        end.to change(Credential, :count).by(1)
      end

      it 'redirects to the created credential' do
        post :create, params: { credential: valid_attributes }, session: valid_session
        expect(response).to redirect_to(Credential.last)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { credential: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end

    context 'with not existing credential' do
      it 'redirects back' do
        Credential.create! valid_attributes
        post :create, params: { credential: valid_attributes }, session: valid_session
        expect(response).to redirect_to(:root)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested credential' do
        credential = Credential.create! valid_attributes
        put :update, params: { id: credential.to_param, credential: new_attributes }, session: valid_session
        credential.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the credential' do
        credential = Credential.create! valid_attributes
        put :update, params: { id: credential.to_param, credential: valid_attributes }, session: valid_session
        expect(response).to redirect_to(credential)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        credential = Credential.create! valid_attributes
        put :update, params: { id: credential.to_param, credential: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested credential' do
      credential = Credential.create! valid_attributes
      expect do
        delete :destroy, params: { id: credential.to_param }, session: valid_session
      end.to change(Credential, :count).by(-1)
    end

    it 'redirects to the credentials list' do
      credential = Credential.create! valid_attributes
      delete :destroy, params: { id: credential.to_param }, session: valid_session
      expect(response).to redirect_to(credentials_url)
    end
  end
end
