require 'rails_helper'

feature 'Delete question', %q{
  In order to delete question
  As an authenticated user
  I want to be able to delete my question
} do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user: user) }

  scenario 'Authenticated user can delete his question' do
    sign_in(user)
    question

    visit questions_path
    click_on 'Delete'

    expect(page).to have_content 'Your question successfully deleted.'
    expect(page).to_not have_content question.title
  end

  scenario 'Authenticated user can\'t delete foreign answer' do
    question
    sign_in(user2)

    visit questions_path

    expect(page).to_not have_link 'Delete'
  end

  scenario 'Non-authenticated user can\'t delete question' do
    question

    visit questions_path

    expect(page).to_not have_link 'Delete'
  end

end