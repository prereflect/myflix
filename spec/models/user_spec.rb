require 'spec_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:queue_items).order('position') }

  describe '#new_queue_item_position' do
    it 'assigns position 1 if My Queue is empty' do
      toby = Fabricate(:user)
      movie_one = Fabricate(:queue_item, user: toby)
      expect(movie_one).to eq(toby.queue_items.first)
    end

    it 'places video at position after last queue item' do
      toby = Fabricate(:user)
      movie_one = Fabricate(:queue_item, user: toby)
      movie_two = Fabricate(:queue_item, user: toby)
      expect(movie_two.id).to eq(movie_one.id + 1)
    end
  end

  describe '#already_queued?(video)' do
    it 'matches a video if it is already in My Queue' do
      toby = Fabricate(:user)
      movie_one = Fabricate(:queue_item, user: toby)
      expect(movie_one.id).to eq(toby.queue_items.first.id)
    end
  end
end
