require_relative 'acceptance_helper'

feature 'Delete files from question', %q{
  In order to delete my files
  As an question's author
  I want to be able to delete files
} do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:attachment) { create(:attachment, attachable: question) }

  scenario 'Author of question trying to delete files', js: true do
    sign_in(user)
    visit question_path(question)

    click_on 'Delete file'

    expect(page).to_not have_content attachment.file.identifier
  end

  scenario 'Foreign author trying to delete files from question', js: true do
    sign_in(user2)
    visit question_path(question)

    expect(page).to_not have_link 'Delete file'
  end

  scenario 'Non-authenticated user trying to delete files', js: true do
    visit question_path(question)

    expect(page).to_not have_link 'Delete file'
  end

end