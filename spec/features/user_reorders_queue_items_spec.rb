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

    user_sets_video_position(decline, 22)
    user_sets_video_position(rashaan, 444)
    user_sets_video_position(lamb, 1)

    click_button 'Update Instant Queue'

    expect_video_position(lamb, 1)
    expect_video_position(decline, 2)
    expect_video_position(rashaan, 3)
  end
end
