require 'spec_helper'

describe Video do
  it 'saves new video' do
    video = Video.new(title: 'New Video', description: 'New Description')
    video.save
    expect(Video.first.title).to eq 'New Video'
    expect(Video.first.description).to eq 'New Description'
  end

  it 'is invalid without a title' do
    video = Video.new(title: nil)
    video.valid?
    expect(video.errors[:title]).to include("can't be blank")
  end

  it 'is invalid without a description' do
    video = Video.new(description: nil)
    video.valid?
    expect(video.errors[:description]).to include("can't be blank")
  end

  it 'has a unique title' do
    Video.create(title: 'New Video', description: 'New Description')
    video = Video.new(title: 'New Video', description: 'Different Description')
    video.valid?
    expect(video.errors[:title]).to include("has already been taken")
  end
end
