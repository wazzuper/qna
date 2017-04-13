require_relative 'acceptance_helper'

feature 'Vote for question', %q{
  In order to give an ability to vote for interesting question
  As an authenticated user
  I want to be able to vote for favorite question
} do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question, user: user) }

  describe 'Authenticated user' do

    scenario 'vote up for other users questions', js: true do
      sign_in(user2)
      visit question_path(question)

      within ".rating-question-#{question.id}" do
        click_on '+'

        expect(page).to have_content 'Rating: 1'
      end

      #within ".rating-question-#{question.id}" do
        #click_on '-'

        #expect(page).to have_content 'Rating: 0'
      #end
    end

    scenario 'author of the question can\'t vote'
  end

  scenario 'Non-authenticated user trying to vote' do
    visit question_path(question)

    expect(page).to_not have_link '+'
    expect(page).to_not have_link '-'
  end
end