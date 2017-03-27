require_relative 'acceptance_helper'

feature 'Edit answer', %q{
  In order to fix answer
  As an author of the answer
  I want to be able to eidt my answer
} do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given(:question2) { create(:question, user: user2) }
  given(:answer) { create(:answer, question: question, user: user) }
  given(:answer2) { create(:answer, question: question2, user: user2) }

  scenario 'Non-authenticated trying to edit answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticated user' do
    before do
      sign_in(user)
      answer
      visit question_path(question)
    end

    scenario 'can see edit link' do
      within '.answers' do
        expect(page).to have_link 'Edit'
      end
    end

    scenario 'can edit his answer', js: true do
      within '.answers' do
        click_on 'Edit'
        fill_in 'Answer', with: 'Edited answer'
        click_on 'Save'
        sleep(1)

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'Edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'can\'t edit other users answers' do
      question2
      answer2
      visit question_path(question2)

      expect(page).to_not have_link 'Edit'
    end
  end

end