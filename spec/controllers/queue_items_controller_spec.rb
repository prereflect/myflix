require 'spec_helper'

describe QueueItemsController do
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
