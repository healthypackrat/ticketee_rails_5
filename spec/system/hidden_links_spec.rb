require "rails_helper"

RSpec.feature "Users can only see the appropriate links", type: :system do
  given(:project) { FactoryBot.create(:project) }
  given(:user) { FactoryBot.create(:user) }
  given(:admin) { FactoryBot.create(:user, :admin) }

  context "anonymous users" do
    scenario "cannot see the New Project link" do
      visit "/"
      expect(page).not_to have_link "New Project"
    end
  end

  context "non-admin users (project viewers)" do
    background do
      login_as(user)
      assign_role!(user, :viewer, project)
    end

    scenario "cannot see the New Project link" do
      visit "/"
      expect(page).not_to have_link "New Project"
    end

    scenario "cannot see the Delete Project link" do
      visit project_path(project)
      expect(page).not_to have_link "Delete Project"
    end
  end

  context "admin users" do
    background { login_as(admin) }

    scenario "can see the New Project link" do
      visit "/"
      expect(page).to have_link "New Project"
    end

    scenario "can see the Delete Project link" do
      visit project_path(project)
      expect(page).to have_link "Delete Project"
    end
  end
end
