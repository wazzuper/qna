require 'rails_helper'

feature 'User sign in', %q{
  In order to be able ask questions
  As an user
  I want to be able sign in
} do

  scenario 'Registered user trying to sign in' do
    User.create!(email: 'user@test.com', password: '123456')

    visit new_user_session_path
    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: '123456'
    click_on 'Sign in'

    expect(page).to have_content 'Signed in successfully'
    expect(current_path).to eq root_path
  end

  scenario 'Non-registered user trying to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'user2@test.com'
    fill_in 'Password', with: '123456'
    click_on 'Sign in'

    expect(page).to have_content 'Invalid email or password'
    expect(current_path).to eq new_user_session_path
  end

end