require_relative 'acceptance_helper'

feature 'Vote for question', %q{
  In order to give an ability to vote for interesting question
  As an authenticated user
  I want to be able to vote for favorite question
} do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question, user: user) }

  describe 'Authenticated user2' do
    before { sign_in(user2) }

    scenario 'vote up for other users questions', js: true do
      visit question_path(question)

      within ".vote-question-#{question.id}" do
        click_on '+'

        expect(page).to have_content 'Rating: 1'
      end
    end

    scenario 'vote down for other users questions', js: true do
      visit question_path(question)

      within ".vote-question-#{question.id}" do
        click_on '-'

        expect(page).to have_content 'Rating: -1'
      end
    end

    scenario 'cancel his vote', js: true do
      visit question_path(question)

      within ".vote-question-#{question.id}" do
        click_on '+'

        expect(page).to have_content 'Rating: 1'
      end

      within ".vote-question-#{question.id}" do
        click_on 'cancel vote'

        expect(page).to_not have_content 'Rating: 1'
        expect(page).to have_content 'Rating: 0'
      end
    end

    scenario 'can\'t vote twice', js: true do
      visit question_path(question)

      within ".vote-question-#{question.id}" do
        click_on '+'

        expect(page).to have_content 'Rating: 1'
      end

      within ".vote-question-#{question.id}" do
        expect(page).not_to have_link '-'
        expect(page).not_to have_link '+'
      end
    end
  end

  scenario 'Author of the question can\'t vote' do
    sign_in(user)
    visit question_path(question)

    expect(page).to_not have_link '+'
    expect(page).to_not have_link '-'
    expect(page).to_not have_link 'cancel vote'
  end

  scenario 'Non-authenticated user trying to vote' do
    visit question_path(question)

    expect(page).to_not have_link '+'
    expect(page).to_not have_link '-'
  end
end