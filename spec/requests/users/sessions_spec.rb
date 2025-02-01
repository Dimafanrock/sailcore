require 'rails_helper'

RSpec.describe 'Users::SessionsController', type: :request do
  let(:password) { User.generate_secure_password }
  let!(:admin) { create(:admin, password: password, password_confirmation: password) }
  let!(:client) { create(:client, password: password, password_confirmation: password) }

  describe 'POST /users/sign_in' do
    context 'when logging in as an admin' do
      it 'redirects to Avo admin panel' do
        post user_session_path, params: { user: { email: admin.email, password: password } }

        follow_redirect!
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when logging in as a client' do
      it 'redirects to the root path' do
        post user_session_path, params: { user: { email: client.email, password: password } }

        expect(response).to redirect_to(root_path)
      end
    end

    context 'when credentials are invalid' do
      it 'does not allow login' do
        post user_session_path, params: { user: { email: admin.email, password: 'wrongpassword' } }

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /users/sign_out' do
    context 'when logged in' do
      before do
        sign_in(admin)
      end

      it 'redirects to login page after logout' do
        delete destroy_user_session_path

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
