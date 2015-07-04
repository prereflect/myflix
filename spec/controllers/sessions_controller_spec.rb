require 'spec_helper'

describe SessionsController do
  let(:toby) { Fabricate(:user) }

  describe 'GET new' do
    it 'redirects to home page for authenticated users' do
      session[:user_id] = toby.id
      get :new
      expect(response).to redirect_to home_path
    end

    it 'renders new template for unauthenticated users' do
      session[:user_id] = nil
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST create' do
    context 'with valid credentials' do
      before(:each) do
        post :create, user: toby,
                      email: toby.email,
                      password: toby.password
      end

      it 'puts the signed in user in the session' do
        expect(session[:user_id]).to eq(toby.id)
      end

      it 'redirects to the home page' do
        expect(response).to redirect_to home_path
      end

      it 'sets the success notice' do
        expect(flash[:success]).not_to be_blank
      end
    end

    context 'with invalid credentials' do
      before(:each) do
        post :create, user: toby,
                      email: toby.email,
                      password: toby.password + 'wrong'
      end

      it 'does not put user in session' do
        expect(session[:user_id]).to be_nil
      end

      it 'redirects to the sign in page' do
        expect(response).to redirect_to sign_in_path
      end

      it 'sets the error notice' do
        expect(flash[:danger]).not_to be_blank
      end
    end
  end

  describe 'GET destroy' do
    before(:each) { get :destroy }

    it 'clears the session for the user' do
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to the root path' do
      expect(response).to redirect_to root_path
    end

    it 'sets the success notice' do
      expect(flash[:success]).not_to be_blank
    end
  end
end
