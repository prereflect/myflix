require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_numericality_of(:position).only_integer }

  let(:toby) { Fabricate(:user) }
  let(:category) { Fabricate(:category, name: 'sports') }
  let(:video) { Fabricate(:video, title: 'Skate or Die!', category: category) }
  let(:queue_item) { Fabricate(:queue_item, user: toby, video: video) }

  describe '#video_title' do
    it 'returns the title of the associated video' do
      expect(queue_item.video_title).to eq('Skate or Die!')
    end
  end

  describe '#rating' do
    it 'returns rating when review is present' do
      review = Fabricate(:review, user: toby, video: video, rating: 4)
      expect(queue_item.rating).to eq(review.rating)
    end

    it 'returns nil when there is no review' do
      expect(queue_item.rating).to eq(nil)
    end
  end

  describe '#category_name' do
    it 'returns the name of the video\'s category' do
      expect(queue_item.category_name).to eq('sports')
    end
  end

  describe '#category' do
    it 'returns the category of the video' do
      expect(queue_item.category).to eq(category)
    end
  end
end
