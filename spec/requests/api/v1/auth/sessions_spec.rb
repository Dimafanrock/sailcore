require 'rails_helper'

RSpec.describe 'API::V1::Auth::Sessions', type: :request do
  let(:password) { User.generate_secure_password }
  let!(:client) { create(:client, password: password, password_confirmation: password) }
  let!(:admin) { create(:admin, password: password, password_confirmation: password) }

  subject(:make_request) { post '/api/v1/auth/sign_in', params: params }

  shared_examples 'an unsuccessful login' do |error_message|
    it 'returns an error response with the correct message' do
      make_request

      expect(response).to have_http_status(:unauthorized)

      json_response = response.parsed_body
      expect(json_response['errors']).to include(error_message)
    end
  end

  describe 'POST /api/v1/auth/sign_in' do
    context 'when logging in as a client' do
      let(:params) { { email: client.email, password: password } }

      it 'returns a valid JWT token and client role' do
        make_request

        expect(response).to have_http_status(:ok)
        expect(response).to render_template('api/v1/clients/show')

        json_response = response.parsed_body
        expect(json_response['user']['email']).to eq(client.email)
        expect(json_response['user']['type']).to eq('Client')
        expect(json_response['user']['token']).to be_present

        decoded_token = JsonWebToken.decode(json_response['user']['token'])
        expect(decoded_token['user_id']).to eq(client.id)
        expect(decoded_token['type']).to eq('Client')
      end
    end

    context 'when logging in as an admin' do
      let(:params) { { email: admin.email, password: password } }

      it 'returns a valid JWT token and admin role' do
        make_request

        expect(response).to have_http_status(:ok)
        expect(response).to render_template('api/v1/clients/show')

        json_response = response.parsed_body
        expect(json_response['user']['email']).to eq(admin.email)
        expect(json_response['user']['type']).to eq('Admin')
        expect(json_response['user']['token']).to be_present

        decoded_token = JsonWebToken.decode(json_response['user']['token'])
        expect(decoded_token['user_id']).to eq(admin.id)
        expect(decoded_token['type']).to eq('Admin')
      end
    end

    context 'when credentials are invalid' do
      let(:params) { { email: client.email, password: 'wrongpassword' } }
      it_behaves_like 'an authentication error', :unauthorized, 'errors.auth.invalid_credentials'
    end

    context 'when email is missing' do
      let(:params) { { password: password } }
      it_behaves_like 'an authentication error', :unauthorized, 'errors.auth.invalid_credentials'
    end

    context 'when password is missing' do
      let(:params) { { email: client.email } }
      it_behaves_like 'an authentication error', :unauthorized, 'errors.auth.invalid_credentials'
    end
  end
end
