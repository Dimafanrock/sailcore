require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:password) { User.generate_secure_password }
  let(:client) { create(:client, password: password, password_confirmation: password) }
  let(:admin) { create(:admin, password: password, password_confirmation: password) }

  describe "GET #index" do
    context "when an admin is logged in" do
      it "redirects to the Avo admin panel" do
        sign_in admin
        get :index, format: :html

        expect(response).to redirect_to(Avo::Engine.routes.url_helpers.root_path)
      end
    end

    context "when a regular user is logged in" do
      it "renders the index page" do
        sign_in client
        get :index, format: :html

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:index)
      end
    end

    context "when no user is logged in" do
      it "renders the index page" do
        get :index, format: :html

        expect(response).to have_http_status(:ok)
      end
    end
  end
end
