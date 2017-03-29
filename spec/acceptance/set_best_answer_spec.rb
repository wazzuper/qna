require_relative 'acceptance_helper'

feature 'Set best answer', %q{
  In order to set the best answer
  As an authenticated user
  I want to be able to set the best answer
} do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given(:answer) { create(:answer, question: question, user: user) }

  describe 'Authenticated user' do

    scenario 'can see link to set the best answer' do
      sign_in(user)
      answer
      visit question_path(question)

      within '.answers' do
        expect(page).to have_link 'Best answer!'
      end
    end

    scenario 'can set the best answer of his question', js: true do
      sign_in(user)
      answer
      visit question_path(question)
      click_on 'Best answer!'

      within '.answers' do
        expect(page).to have_content 'This is the best answer!'
      end
    end

    scenario 'can\'t set the best answer in foreign question' do
      sign_in(user2)
      answer
      visit question_path(question)

      within '.answers' do
        expect(page).to_not have_link 'Best answer!'
      end
    end
  end

  scenario 'Non-authenticated user can\'t choose the best answer' do
    visit question_path(question)

    within '.answers' do
      expect(page).to_not have_link 'Best answer!'
    end
  end

  scenario 'Only one best answer can exist', js: true do
    sign_in(user)
    answers = create_list(:answer, 3, question: question, user: user)
    visit question_path(question)

    within ".answer_#{answers[0].id}" do
      click_on 'Best answer!'

      expect(page).to have_content 'This is the best answer!'
    end

    within ".answer_#{answers[-1].id}" do
      click_on 'Best answer!'

      expect(page).to have_content 'This is the best answer!'
    end

    within ".answer_#{answers[0].id}" do
      click_on 'Best answer!'

      expect(page).to_not have_link 'Best answer!'
    end
  end

end