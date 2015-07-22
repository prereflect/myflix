require 'spec_helper'

feature 'Visitor signs up' do
  scenario 'with valid email and password' do
    visitor_signs_up_with 'valid@example.com', 'password', 'Valid Example'

    expect(page).to have_content('Sign in')
  end

  scenario 'with blank password' do
    visitor_signs_up_with 'valid@example.com', '', 'Valid Example'

    expect(page).to have_content('can\'t be blank')
  end
end

def visitor_signs_up_with(email, password, full_name)
  visit register_path
  fill_in 'Email Address', with: email
  fill_in 'Password', with: password
  fill_in 'Full Name', with: full_name
  click_button 'Sign Up'
end
