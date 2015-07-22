require 'spec_helper'

feature 'User adds video to My Queue' do
  given!(:music) { Fabricate(:category, name: 'music') }
  given!(:decline) { Fabricate(:video, category: music) }

  before do
    sign_in

    click_on 'Videos'
    find("a[href='#{video_path(decline)}']").click
    click_on '+ My Queue'
  end

  scenario 'shows video on My Queue page' do
    expect(page).to have_content decline.title
  end

  scenario 'correctly links back to video' do
    find("a[href='#{video_path(decline)}']").click

    expect(current_path).to eq(video_path(decline))
  end

  scenario '+ My Queue button will not be on video page' do
    find("a[href='#{video_path(decline)}']").click

    expect(page).to_not have_content('+ My Queue')
  end
end
