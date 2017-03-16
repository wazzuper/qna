require 'rails_helper'

feature 'Create answer', %q{
  In order to give an answer
  As an authenticated user
  I want to be able to give an answer
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }

  scenario 'Authenticated user creates answer' do
    sign_in(user)

    visit question_path(question)
    fill_in 'Body', with: 'Interesting answer'
    click_on 'Give an answer'

    expect(page).to have_content 'Your answer successfully created.'
    expect(page).to have_content 'Interesting answer'
  end

  scenario 'Authenticated user creates empty answer' do
    sign_in(user)

    visit question_path(question)
    fill_in 'Body', with: ''
    click_on 'Give an answer'

    expect(page).to have_content 'Body can\'t be blank'
  end

  scenario 'Non-authenticated user trying to create answer' do
    visit question_path(question)
    fill_in 'Body', with: 'Interesting answer'
    click_on 'Give an answer'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end