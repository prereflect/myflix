require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_numericality_of(:position).only_integer }

  describe '#video_title' do
    it 'returns the title of the associated video' do
      toby = Fabricate(:user)
      sports  = Fabricate(:category, name: 'sports')
      skate = Fabricate(:video, title: 'Skate or Die!', category: sports)
      queue_item = Fabricate(:queue_item, user: toby, video: skate)
      expect(queue_item.video_title).to eq('Skate or Die!')
    end
  end

  describe '#rating' do
    let(:toby) { Fabricate(:user) }
    let(:sports) { Fabricate(:category, name: 'sports') }
    let(:skate) { Fabricate(:video, category: sports) }
    let(:queue_item) { Fabricate(:queue_item, user: toby, video: skate) }

    it 'returns rating when review is present' do
      review = Fabricate(:review, user: toby, video: skate, rating: 4)
      expect(queue_item.rating).to eq(review.rating)
    end

    it 'returns nil when there is no review' do
      expect(queue_item.rating).to eq(nil)
    end
  end

  describe '#rating=' do
    let(:toby) { Fabricate(:user) }
    let(:sports) { Fabricate(:category, name: 'sports') }
    let(:skate) { Fabricate(:video, category: sports) }
    let(:queue_item) { Fabricate(:queue_item, user: toby, video: skate) }

    it 'creates rating with review if no review' do
      queue_item.rating = 2
      expect(Review.first.rating).to eq(2)
    end

    it 'changes rating of review if review present' do
      Fabricate(:review, user: toby, video: skate, rating: 4)
      queue_item.rating = 2
      expect(Review.first.rating).to eq(2)
    end

    it 'clears rating if review present' do
      Fabricate(:review, user: toby, video: skate, rating: 4)
      queue_item.rating = nil
      expect(Review.first.rating).to be_nil
    end
  end

  describe '#category_name' do
    it 'returns the name of the video\'s category' do
      toby = Fabricate(:user)
      sports = Fabricate(:category, name: 'sports')
      skate = Fabricate(:video, category: sports)
      queue_item = Fabricate(:queue_item, user: toby, video: skate)
      expect(queue_item.category_name).to eq('sports')
    end
  end

  describe '#category' do
    it 'returns the category of the video' do
      toby = Fabricate(:user)
      sports = Fabricate(:category, name: 'sports')
      skate = Fabricate(:video, category: sports)
      queue_item = Fabricate(:queue_item, user: toby, video: skate)
      expect(queue_item.category).to eq(sports)
    end
  end
end
