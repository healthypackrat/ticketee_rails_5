require "rails_helper"

RSpec.feature "Users can delete tickets", type: :system do
  given(:author)  { FactoryBot.create(:user) }
  given(:project) { FactoryBot.create(:project) }
  given(:ticket) do
    FactoryBot.create(:ticket, project: project, author: author)
  end

  background do
    login_as(author)
    assign_role!(author, :manager, project)
    visit project_ticket_path(project, ticket)
  end

  scenario "successfully" do
    click_link "Delete Ticket"

    expect(page).to have_content "Ticket has been deleted."
    expect(page.current_url).to eq project_url(project)
  end
end
