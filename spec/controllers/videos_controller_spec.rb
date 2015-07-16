require 'spec_helper'

describe VideosController do
  describe 'GET show' do
    before { set_current_user }
    let(:video) { Fabricate(:video) }

    it 'sets @video for authenticated user' do
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end

    it 'sets @reviews for authenticated user' do
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      get :show, id: video.id
      expect(assigns(:reviews)).to match_array([review1, review2])
    end

    it_behaves_like 'require_sign_in' do
      let(:action) { get :show, id: video.id }
    end
  end

  describe 'POST search' do
    before { set_current_user }
    let(:futurama) { Fabricate(:video, title: 'Futurama') }

    it 'sets @results for authenticated user' do
      post :search, search_term: 'rama'
      expect(assigns(:results)).to eq([futurama])
    end

    it_behaves_like 'require_sign_in' do
      let(:action) { post :search, search: 'rama' }
    end
  end
end
