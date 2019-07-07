require 'rails_helper'

RSpec.describe "admin/application", type: :request do
  let(:user) { FactoryBot.create(:user) }

  before do
    login_as(user)

    allow_any_instance_of(Admin::ApplicationController).to receive(:current_user).and_return(user)
  end

  context "non-admin users" do
    it "are not able to access the index action" do
      get admin_root_path

      expect(response).to redirect_to "/"
      expect(flash[:alert]).to eq "You must be an admin to do that."
    end
  end
end
