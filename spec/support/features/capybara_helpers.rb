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

def user_clicks_on(link_text)
  click_on link_text
end

def user_selects_video_on_page(video)
  find("a[href='#{video_path(video)}']").click
end
