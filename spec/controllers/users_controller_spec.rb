require 'spec_helper'

describe UsersController do
  describe 'GET new' do
    it 'sets @user' do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe 'POST create' do
    context 'with valid input' do
      let(:toby) { Fabricate.attributes_for(:user) }
      before { post :create, user: toby }

      it 'creates the user' do
        expect(User.count).to eq(1)
      end

      it 'redirects to the sign in page' do
        expect(response).to redirect_to sign_in_path
      end
    end

    context 'with invalid input' do
      let(:toby) { Fabricate.attributes_for(:user) }
      before { post :create, user: toby.merge(email: '') }

      it 'does not create the user' do
        expect(User.count).to eq(0)
      end

      it 'renders new template' do
        expect(response).to render_template :new
      end

      it 'sets @user' do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end
end
