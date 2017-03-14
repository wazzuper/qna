require 'rails_helper'

feature 'Create answer', %q{
  In order to give an answer
  As an authenticated user
  I want to be able to give an answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user create answer' do
    sign_in(user)

    visit questions_path(question)
    click_on 'MyString'
    fill_in 'Body', with: 'Interesting answer'
    click_on 'Give an answer'

    expect(page).to have_content 'Interesting answer'
  end

  scenario 'Non-authenticated user trying to create answer' do
    visit questions_path(question)
    click_on 'MyString'
    fill_in 'Body', with: 'Interesting answer'
    click_on 'Give an answer'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end