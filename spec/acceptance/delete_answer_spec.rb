require 'rails_helper'

feature 'Delete answer', %q{
  In order to delete an answer
  As an authenticated user
  I want to be able to delete an answer
} do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'Authenticated user can delete his answer' do
    sign_in(user)

    visit question_path(question)
    click_on 'Delete'

    expect(page).to have_content 'Your answer successfully deleted.'
    expect(page).to_not have_content answer.body
  end

  scenario 'Authenticated user can\'t delete foreign answer' do
    sign_in(user2)

    visit question_path(question)

    expect(page).to_not have_link 'Delete'
  end

  scenario 'Non-authenticated user can\'t delete answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Delete'
  end

end