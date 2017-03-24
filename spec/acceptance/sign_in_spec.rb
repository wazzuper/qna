require_relative 'acceptance_helper'

feature 'User sign in', %q{
  In order to be able ask questions
  As an user
  I want to be able sign in
} do

  #элиас метода let для исп. в acceptance тестах
  given(:user) { create(:user) }

  scenario 'Registered user trying to sign in' do
    sign_in(user)

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Non-registered user trying to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong_user@test.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password.'
    expect(current_path).to eq new_user_session_path
  end

end