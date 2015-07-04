require 'spec_helper'

describe QueueItemsController do
  let(:toby) { Fabricate(:user) }
  before(:each) { session[:user_id] = toby.id }

  describe 'GET index' do
    context 'with authenticated user' do
      it 'sets @queue_items of authenticated user' do
        queue_item1 = Fabricate(:queue_item, user: toby)
        queue_item2 = Fabricate(:queue_item, user: toby)
        get :index
        expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
      end
    end

    context 'with unauthenticated user' do
      before { session[:user_id] = nil }

      it 'redirects to sign in page' do
        get :index
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe 'POST create' do
    let(:spider) { Fabricate(:video) }

    context 'with authenticated user' do
      it 'redirects to My Queue page' do
        post :create, video_id: spider.id
        expect(response).to redirect_to my_queue_path
      end

      it 'creates a queue item' do
        post :create, video_id: spider.id
        expect(QueueItem.count).to eq(1)
      end

      it 'creates a queue item associated with video' do
        post :create, video_id: spider.id
        expect(QueueItem.first.video).to eq(spider)
      end

      it 'creates a queue item associated with current user' do
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
    end

    context 'with unauthenticated user' do
      before { session[:user_id] = nil }

      it 'redirects to the sign in page' do
        post :create, video_id: spider.id
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe 'DELETE destroy' do
    let(:queue_item) { Fabricate(:queue_item, user: toby) }
    before(:each) { delete :destroy, id: queue_item.id }

    context 'with authenticated user' do
      it 'redirects to the My Queue page' do
        expect(response).to redirect_to my_queue_path
      end

      it 'deletes the queue item' do
        expect(QueueItem.count).to eq(0)
      end

      it 'does not delete queue item if not in current user\'s queue' do
        alice = Fabricate(:user)
        queue_item_alice = Fabricate(:queue_item, user: alice)
        delete :destroy, id: queue_item_alice.id
        expect(QueueItem.count).to eq(1)
      end
    end

    context 'with unauthenticated user' do
      before { session[:user_id] = nil }

      it 'redirects to the sign in page' do
        queue_item = Fabricate(:queue_item)
        delete :destroy, id: queue_item.id
        expect(response).to redirect_to sign_in_path
      end
    end
  end
end
