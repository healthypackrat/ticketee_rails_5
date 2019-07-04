require "rails_helper"

RSpec.feature "Signed-in users can sign out", type: :system do
  given!(:user) { FactoryBot.create(:user) }

  background do
    login_as(user)
  end

  scenario do
    visit "/"
    click_link "Sign out"
    expect(page).to have_content "Signed out successfully."
  end
end
