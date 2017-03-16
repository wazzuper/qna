require 'rails_helper'

feature 'List of questions', %q{
  In order to look interested question
  As an user
  I want to be able view questions
} do

  given(:user) { create(:user) }
  given!(:questions) { create_list(:question, 5, user: user) }

  scenario 'Authenticated user looks list of questions' do
    sign_in(user)

    visit questions_path

    questions.each do |q|
      expect(page).to have_content q.title
    end
  end

  scenario 'Non-authenticated user looks list of questions' do
    visit questions_path

    questions.each do |q|
      expect(page).to have_content q.title
    end
  end

end