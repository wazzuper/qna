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
    scenario 'vote up for question'

    scenario 'vote down for question'

    scenario 'author of the question can\'t vote'

    scenario 'vote rejected'
  end

  scenario 'Non-authenticated user trying to vote' do
    visit question_path(question)

    expect(page).to_not have_link 'Up'
    expect(page).to_not have_link 'Down'
  end
end