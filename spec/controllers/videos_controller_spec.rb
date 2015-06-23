require 'spec_helper'

describe VideosController do
  describe 'GET show' do
    it 'sets @video for authenticated user' do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end

    it 'sets @reviews for authenticated user' do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      get :show, id: video.id
      expect(assigns(:reviews)).to match_array([review1, review2])
    end

    it 'redirects unauthenticated user to sign in page' do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to sign_in_path
    end
  end

  describe 'POST search' do
    let(:futurama) { Fabricate(:video, title: 'Futurama') }

    it 'sets @results for authenticated user' do
      session[:user_id] = Fabricate(:user).id
      post :search, search_term: 'rama'
      expect(assigns(:results)).to eq([futurama])
    end

    it 'redirects unauthenticated user to sign in page' do
      post :search, search_term: 'rama'
      expect(response).to redirect_to sign_in_path
    end
  end
end
