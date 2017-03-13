require 'rails_helper'

feature 'List of questions', %q{
  In order to look interested question
  As an user
  I want to be able view questions
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user looks list of questions' do
    sign_in(user)

    expect(current_path).to eq root_path
  end

  scenario 'Non-authenticated user looks list of questions' do
    visit root_path

    expect(current_path).to eq root_path
  end

end