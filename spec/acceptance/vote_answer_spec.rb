require_relative 'acceptance_helper'

feature 'Vote for answer', %q{
  In order to give an ability to vote for interesting answer
  As an authenticated user
  I want to be able to vote for favorite answer
} do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  describe 'Authenticated user2' do
    before { sign_in(user2) }

    scenario 'vote up for other users answers', js: true do
      visit question_path(question)

      within ".vote-answer-#{answer.id}" do
        click_on '+'

        expect(page).to have_content 'Rating: 1'
      end
    end

    scenario 'vote down for other users answers', js: true do
      visit question_path(question)

      within ".vote-answer-#{answer.id}" do
        click_on '-'

        expect(page).to have_content 'Rating: -1'
      end
    end

    scenario 'cancel his vote', js: true do
      visit question_path(question)

      within ".vote-answer-#{answer.id}" do
        click_on '+'

        expect(page).to have_content 'Rating: 1'
      end

      within ".vote-answer-#{answer.id}" do
        click_on 'cancel vote'

        expect(page).to_not have_content 'Rating: 1'
        expect(page).to have_content 'Rating: 0'
      end
    end

    scenario 'can\'t vote twice', js: true do
      visit question_path(question)

      within ".vote-answer-#{answer.id}" do
        click_on '+'

        expect(page).to have_content 'Rating: 1'
      end

      within ".vote-answer-#{answer.id}" do
        expect(page).not_to have_link '-'
        expect(page).not_to have_link '+'
      end
    end
  end

  scenario 'Author of the answer can\'t vote' do
    sign_in(user)
    visit question_path(question)

    within '.answers' do
      expect(page).to_not have_link '+'
      expect(page).to_not have_link '-'
      expect(page).to_not have_link 'cancel vote'
    end
  end

  scenario 'Non-authenticated user trying to vote' do
    visit question_path(question)

    within '.answers' do
      expect(page).to_not have_link '+'
      expect(page).to_not have_link '-'
    end
  end
end