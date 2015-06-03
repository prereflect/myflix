require 'spec_helper'

describe Category do
  it { should have_many(:videos).order('title') }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  describe '#recent_videos' do
    it 'returns the videos in the reverse chronological order' do
      sports = Category.create(name: 'sports')

      skate = Video.create(title: 'Skate or Die', description: 'Not really', category: 'sports', created_at: 1.day.ago)
      snowboard = Video.create(title: 'Snowboard or Die', description: 'Not really', category: 'sports')

      expect(sports.recent_videos).to eq([snowboard, skate])
    end
  end
end
