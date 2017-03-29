require_relative 'acceptance_helper'

feature 'Set best answer', %q{
  In order to set the best answer
  As an authenticated user
  I want to be able to set the best answer
} do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  describe 'Authenticated user' do

    scenario 'can set the best answer of his question'

    scenario 'can\'t set the best answer in foreign question'
  end

  scenario 'Non-authenticated user can\'t choose the best answer'

end