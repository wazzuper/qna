require_relative 'acceptance_helper'

feature 'Delete question', %q{
  In order to delete question
  As an authenticated user
  I want to be able to delete my question
} do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question, user: user) }

  scenario 'Authenticated user can delete his question' do
    sign_in(user)
    visit question_path(question)

    click_on 'Delete this question'

    expect(page).to have_content 'Your question successfully deleted.'
    expect(current_path).to eq root_path
    expect(page).to_not have_content question.title
  end

  scenario 'Authenticated user can\'t delete foreign question' do
    sign_in(user2)
    visit question_path(question)

    expect(page).to_not have_link 'Delete this question'
  end

  scenario 'Non-authenticated user can\'t delete question' do
    visit question_path(question)

    expect(page).to_not have_link 'Delete this question'
  end

end