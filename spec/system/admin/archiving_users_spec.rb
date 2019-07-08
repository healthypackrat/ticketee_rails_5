require "rails_helper"

RSpec.feature "An admin can archive users", type: :system do
  given(:admin_user) { FactoryBot.create(:user, :admin) }
  given(:user) { FactoryBot.create(:user) }

  background do
    login_as(admin_user)
  end

  scenario "successfully", js: true do
    visit admin_user_path(user)
    accept_confirm { click_link "Archive User" }

    expect(page).to have_content "User has been archived"
    expect(page).not_to have_content user.email
  end

  scenario "but cannot archive themselves", js: true do
    visit admin_user_path(admin_user)
    accept_confirm { click_link "Archive User" }

    expect(page).to have_content "You cannot archive yourself!"
  end
end
