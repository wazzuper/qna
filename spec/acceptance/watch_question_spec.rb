require 'rails_helper'

feature 'View question and answers', %q{
  In order to look question and answers
  As an user
  I want to be able to view question with answers
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:answers) { create_list(:answer, 2, question: question) }

  scenario 'Authenticated user watch question' do
    sign_in(user)
    visit questions_path(question)
    answers
    click_on question.title

    expect(page).to have_content question.title
    answers.each do |a|
      expect(page).to have_content a.body
    end
  end

  scenario 'Non-authenticated user watch question' do
    visit questions_path(question)
    answers
    click_on question.title

    expect(page).to have_content question.title
    answers.each do |a|
      expect(page).to have_content a.body
    end
  end

end