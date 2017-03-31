require_relative 'acceptance_helper'

feature 'Users registration', %q{
  In order to be able use this site for ask questions and so on
  As an non-authenticated user
  I want to be able to register
} do

  given(:user) { create(:user) }

  scenario 'Non-registered user trying to sign up' do
    visit new_user_registration_path
    fill_in 'Email', with: 'new_user@test.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    within '.actions' do
      click_on 'Sign up'
    end

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Registered user trying to sign up' do
    visit new_user_registration_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    within '.actions' do
      click_on 'Sign up'
    end

    expect(page).to have_content 'Email has already been taken'
    expect(current_path).to eq user_registration_path
  end

end