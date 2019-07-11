require "rails_helper"

RSpec.feature "Users can view projects", type: :system do
  given(:user) { FactoryBot.create(:user) }
  given(:project) { FactoryBot.create(:project, name: "Sublime Text 3") }

  background do
    login_as(user)
    assign_role!(user, :viewer, project)
  end

  scenario "with the project details" do
    visit "/"
    click_link "Sublime Text 3"
    expect(page.current_url).to eq project_url(project)
  end
end
