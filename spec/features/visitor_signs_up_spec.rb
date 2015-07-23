require 'spec_helper'

feature 'Visitor signs up' do
  scenario 'with valid email and password' do
    visitor_signs_up_with 'john.doe@example.com', 'password', 'John Doe'

    expect(page).to have_content('Sign in')
  end

  scenario 'with blank password' do
    visitor_signs_up_with 'john.doe@example.com', '', 'John Doe'

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
