require 'spec_helper'

describe Video do
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should have_many(:reviews).order('created_at desc') }

  describe '.search_by_title' do
    let!(:dragon) { Video.create(title: 'How to Train Your Dragon',
                                 description: 'Hiccup and Toothless, BFF') }
    let(:cop) { Video.create(title: 'Training Day',
                             description: 'Bad Cop, Good Cop') }

    it 'returns an empty array if there is no match' do
      expect(Video.search_by_title('hello')).to eq([])
    end

    it 'returns an empty array with a search for an empty string' do
      expect(Video.search_by_title('')).to eq([])
    end

    it 'returns an array of one video for an exact match' do
      expect(Video.search_by_title('How to Train Your Dragon')).to eq([dragon])
    end

    it 'returns an array of one video for a partial match' do
      expect(Video.search_by_title('how')).to eq([dragon])
    end

    it 'returns an array of all matches ordered by created_at desc' do
      expect(Video.search_by_title('train')).to eq([cop, dragon])
    end
  end
end
