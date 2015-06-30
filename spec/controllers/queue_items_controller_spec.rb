require 'spec_helper'

describe QueueItemsController do
  describe 'GET index' do
    it 'sets @queue_items of authenticated user' do
      toby = Fabricate(:user)
      session[:user_id] = toby.id
      queue_item1 = Fabricate(:queue_item, user: toby)
      queue_item2 = Fabricate(:queue_item, user: toby)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end

    it 'redirects to sign in page for unathenticated user' do
      get :index
      expect(response).to redirect_to sign_in_path
    end
  end

  describe 'POST create' do
    let (:toby) { Fabricate(:user) }
    let (:spider) { Fabricate(:video) }
    before(:each) { session[:user_id] = toby.id }

    it 'redirects to My Queue page' do
      post :create, video_id: spider.id
    end

    it 'creates a queue item' do
      post :create, video_id: spider.id
      expect(QueueItem.count).to eq(1)
    end

    it 'creates a queue item associated with video' do
      post :create, video_id: spider.id
      expect(QueueItem.first.video).to eq(spider)
    end

    it 'creates a queue item associated with authenticated user' do
      post :create, video_id: spider.id
      expect(QueueItem.first.user).to eq(toby)
    end

    it 'stores a queue item in the last position' do
      Fabricate(:queue_item, video: spider, user: toby)
      man = Fabricate(:video)
      post :create, video_id: man.id
      man_queue_item = QueueItem.where(video_id: man, user_id: toby.id).first
      expect(man_queue_item.position).to eq(2)
    end

    it 'does not create a queue item when video is already in queue' do
      Fabricate(:queue_item, video: spider, user: toby)
      post :create, video_id: spider.id
      expect(toby.queue_items.count).to eq(1)
    end

    it 'redirects to the sign in page for unathenticated user' do
      session[:user_id] = nil
      post :create, video_id: spider.id
      expect(response).to redirect_to sign_in_path
    end
  end
end
