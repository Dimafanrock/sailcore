require 'rails_helper'

RSpec.describe 'API::V1::Auth::Sessions', type: :request do
  let(:password) { User.generate_secure_password }
  let!(:client) { create(:client, password: password, password_confirmation: password) }
  let!(:admin) { create(:admin, password: password, password_confirmation: password) }

  describe 'POST /api/v1/auth/sign_in' do
    context 'when logging in as a client' do
      it 'returns a valid JWT token and client role' do
        post '/api/v1/auth/sign_in', params: { email: client.email, password: password }
        expect(response).to have_http_status(:ok)

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
      it 'returns a valid JWT token and admin role' do
        post '/api/v1/auth/sign_in', params: { email: admin.email, password: password }

        expect(response).to have_http_status(:ok)

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
      it 'returns an error' do
        post '/api/v1/auth/sign_in', params: { email: client.email, password: 'wrongpassword' }

        expect(response).to have_http_status(:unauthorized)

        json_response = response.parsed_body
        expect(json_response['error']).to be_present
      end
    end
  end
end
