require 'spec_helper'

describe Category do
  it { should have_many(:videos).order('created_at desc') }
  it { should validate_presence_of(:name) }

  describe '#recent_videos' do
    let(:sports) { Category.create(name: 'sports', id: 1) }

    it 'returns an empty array if the category has no videos' do
      expect(sports.recent_videos).to eq([])
    end

    it 'returns all of the videos in the reverse chronological order' do
      skate = Fabricate(:video, category: sports)
      snowboard = Fabricate(:video, category: sports)
      expect(sports.recent_videos).to eq([snowboard, skate])
    end

    it 'returns all of the videos if there are less than 6 videos' do
      Fabricate.times(2, :video, category: sports)
      expect(sports.recent_videos.count).to eq(2)
    end

    it 'returns the most recent 6 videos if there are more than 6 videos' do
      skate = Fabricate(:video, category: sports, created_at: 1.day.ago)
      Fabricate.times(6, :video, category: sports)
      expect(sports.recent_videos).not_to include(skate)
    end
  end
end
