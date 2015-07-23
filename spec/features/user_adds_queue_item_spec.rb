require 'spec_helper'

feature 'User adds video to My Queue' do
  given!(:music) { Fabricate(:category, name: 'music') }
  given!(:decline) { Fabricate(:video, category: music) }

  before do
    sign_in

    user_clicks_on('Videos')
    user_selects_video_on_page(decline)
    user_clicks_on('+ My Queue')
  end

  scenario 'shows video on My Queue page' do
    expect(page).to have_content decline.title
  end

  scenario 'correctly links back to video' do
    user_selects_video_on_page(decline)

    expect(current_path).to eq(video_path(decline))
  end

  scenario '+ My Queue button will not be on video page' do
    expect(page).to_not have_content('+ My Queue')
  end
end
