require_relative 'acceptance_helper'

feature 'Create answer', %q{
  In order to give an answer
  As an authenticated user
  I want to be able to give an answer
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }

  scenario 'Authenticated user creates answer', js: true do
    sign_in(user)

    visit question_path(question)
    fill_in 'Answer', with: 'Interesting answer'
    click_on 'Give an answer'
    sleep(1)

    expect(page).to have_content 'Interesting answer'
  end

  scenario 'Authenticated user creates empty answer', js: true do
    sign_in(user)

    visit question_path(question)
    click_on 'Give an answer'
    sleep(1)

    within '.answer-errors-new' do
      expect(page).to have_content 'Body can\'t be blank'
    end
  end

  scenario 'Non-authenticated user trying to create answer' do
    visit question_path(question)
    fill_in 'Answer', with: 'Interesting answer'
    click_on 'Give an answer'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end