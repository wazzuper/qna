require_relative 'acceptance_helper'

feature 'User sign out', %q{
  In order to be able log out
  As an user
  I want to be able sign out
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user trying to sign out' do
    sign_in(user)
    click_on 'Log out'

    expect(page).to have_content 'Signed out successfully.'
    expect(current_path).to eq root_path
  end

end
