def sign_up_with(email, password, full_name)
  visit register_path
  fill_in 'Email Address', with: email
  fill_in 'Password', with: password
  fill_in 'Full Name', with: full_name
  click_button 'Sign Up'
end

def sign_in
  user = Fabricate(:user)
  visit sign_in_path
  fill_in 'email', with: user.email
  fill_in 'password', with: user.password
  click_button 'Sign in'
end

def sign_out
  visit sign_out_path
end

def user_adds_video_to_my_queue(video)
  click_on 'Videos'
  find("a[href='#{video_path(video)}']").click
  click_on '+ My Queue'
end

def user_sets_video_position(video, position)
  within(:xpath, "//tr[contains(.,'#{video.title}')]") do
    fill_in "queue_items[][position]", with: position
  end
end

def expect_video_position(video, position)
  expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input[@type='text']"
             ).value).to eq(position.to_s)
end
