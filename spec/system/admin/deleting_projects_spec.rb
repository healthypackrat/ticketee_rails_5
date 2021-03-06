require "rails_helper"

RSpec.feature "Users can delete projects", type: :system do
  background do
    login_as(FactoryBot.create(:user, :admin))
  end

  scenario "successfully", js: true do
    FactoryBot.create(:project, name: "Sublime Text 3")

    visit "/"
    click_link "Sublime Text 3"
    accept_confirm { click_link "Delete Project" }

    expect(page).to have_content "Project has been deleted."
    expect(page.current_url).to eq projects_url(port: current_port)
    expect(page).to have_no_content "Sublime Text 3"
  end
end
