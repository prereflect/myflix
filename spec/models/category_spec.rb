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
      skate = Video.create(title: 'Skate or Die', description: 'Not really', category: sports)
      snowboard = Video.create(title: 'Snowboard or Die', description: 'Not really', category: sports)
      expect(sports.recent_videos).to eq([snowboard, skate])
    end

    it 'returns all of the videos if there are less than 6 videos' do
      skate = Video.create(title: 'Skate or Die', description: 'Not really', category: sports)
      snowboard = Video.create(title: 'Snowboard or Die', description: 'Not really', category: sports)
      expect(sports.recent_videos.count).to eq(2)
    end

    it 'returns the most recent 6 videos if there are more than 6 videos' do
      skate = Video.create(title: 'Skate or Die', description: 'Not really', category: sports, created_at: 1.day.ago)
      6.times { Video.create(title: 'foo', description: 'bar', category: sports) }
      expect(sports.recent_videos).not_to include(skate)
    end
  end
end
