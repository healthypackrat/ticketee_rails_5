require 'rails_helper'

RSpec.describe "Projects", type: :request do
  it "handles a missing project correctly" do
    get project_path("not-here")

    expect(response).to redirect_to(projects_path)

    message = "The project you were looking for could not be found."
    expect(flash[:alert]).to eq message
  end

  it "handles permission errors by redirecting to a safe place" do
    project = FactoryBot.create(:project)
    get project_path(project)

    expect(response).to redirect_to(root_path)
    message = "You aren't allowed to do that."
    expect(flash[:alert]).to eq message
  end
end
