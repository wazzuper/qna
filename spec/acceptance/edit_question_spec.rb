require_relative 'acceptance_helper'

feature 'Edit question', %q{
  In order to fix question
  As an author of the question
  I want to be able to edit my question
} do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question, user: user) }

  scenario 'Non-authenticated trying to edit question' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit my question'
  end

  describe 'Authenticated user' do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'can see edit link' do
      within '.question' do
        expect(page).to have_link 'Edit my question'
      end
    end

    scenario 'can edit his question', js: true do
      within '.question' do
        click_on 'Edit my question'
        fill_in 'Title', with: 'Edited question title'
        fill_in 'Body', with: 'Edited question body'
        click_on 'Save'

        expect(page).to_not have_content question.title
        expect(page).to_not have_content question.body
        expect(page).to have_content 'Edited question title'
        expect(page).to have_content 'Edited question body'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'can\'t save with empty title', js: true do
      within '.question' do
        click_on 'Edit my question'
        fill_in 'Title', with: ''
        click_on 'Save'

        expect(page).to have_content 'Title can\'t be blank'
      end
    end

    scenario 'can\'t save with empty body', js: true do
      within '.question' do
        click_on 'Edit my question'
        fill_in 'Body', with: ''
        click_on 'Save'

        expect(page).to have_content 'Body can\'t be blank'
      end
    end
  end

  scenario 'Authenticated user can\'t edit foreign question' do
    sign_in(user2)
    visit question_path(question)

    expect(page).to_not have_link 'Edit my question'
  end
end