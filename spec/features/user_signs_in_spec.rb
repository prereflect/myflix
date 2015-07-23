require 'spec_helper'

feature 'User Sign In' do
  given(:toby) { Fabricate(:user) }

  background do
    visit root_path
    user_clicks_on('Sign in')
  end

  scenario 'with correct credentials' do
    fill_in 'email', with: toby.email
    fill_in 'password', with: toby.password
    user_clicks_on('Sign in')
    expect(page).to have_content 'You are now signed in'
  end

  scenario 'with incorrect password' do
    fill_in 'email', with: toby.email
    fill_in 'password', with: toby.password + 'wrong'
    user_clicks_on('Sign in')
    expect(page).to have_content 'Invalid email or password'
  end

  scenario 'with blank password' do
    fill_in 'email', with: toby.email
    fill_in 'password', with: nil
    user_clicks_on('Sign in')
    expect(page).to have_content 'Invalid email or password'
  end
end
