require 'rails_helper'

feature 'Users registration', %q{
  In order to be able use this site for ask questions and so on
  As an non-authenticated user
  I want to be able to register
} do

  given(:user) { create(:user) }

  scenario 'Non-registered user trying to sign up' do
    visit new_user_session_path
    click_on 'Sign up'
    fill_in 'Email', with: 'new_user@test.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Registered user trying to sign up' do
    visit new_user_session_path
    click_on 'Sign up'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_on 'Sign up'

    expect(page).to have_content 'Email has already been taken'
    expect(current_path).to eq user_registration_path
  end

end