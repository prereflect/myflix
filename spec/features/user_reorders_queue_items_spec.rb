require 'spec_helper'

feature 'User reorders My Queue' do
  given!(:music) { Fabricate(:category, name: 'music') }
  given!(:decline) { Fabricate(:video, category: music) }
  given!(:rashaan) { Fabricate(:video, category: music) }
  given!(:lamb) { Fabricate(:video, category: music) }

  scenario 'changes queue positions of videos' do
    sign_in

    user_adds_video_to_my_queue(decline)
    user_adds_video_to_my_queue(rashaan)
    user_adds_video_to_my_queue(lamb)

    user_changes_video_position(decline, 22)
    user_changes_video_position(rashaan, 444)
    user_changes_video_position(lamb, 1)

    update_my_queue

    expect_video_position(lamb, 1)
    expect_video_position(decline, 2)
    expect_video_position(rashaan, 3)
  end
end

def user_adds_video_to_my_queue(video)
  user_clicks_on('Video')
  user_selects_video_on_page(video)
  user_clicks_on('+ My Queue')
end

def user_changes_video_position(video, position)
  within(:xpath, "//tr[contains(.,'#{video.title}')]") do
    fill_in "queue_items[][position]", with: position
  end
end

def update_my_queue
  user_clicks_on('Update Instant Queue')
end

def expect_video_position(video, position)
  expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input[@type='text']"
             ).value).to eq(position.to_s)
end
