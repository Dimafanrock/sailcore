require 'rails_helper'

RSpec.describe 'User Registration', type: :request do
  let(:valid_params) do
    {
      user: {
        email: 'client@example.com',
        name: 'John Doe',
        nickname: 'johnny'
      }
    }
  end

  let(:invalid_params) do
    {
      user: {
        email: 'invalid',
        name: 'J'
      }
    }
  end

  describe 'POST /api/v1/auth' do
    context 'with valid details' do
      it 'creates a client' do
        expect { post '/api/v1/auth', params: valid_params }
          .to change { Client.count }.by(1)

        expect(response).to have_http_status(:ok)

        json_response = response.parsed_body

        expect(json_response['user']['email']).to eq(valid_params[:user][:email])
        expect(json_response['user']['token']).to be_present

        decoded_token = JsonWebToken.decode(json_response['user']['token'])
        expect(decoded_token['user_id']).to be_present
        expect(decoded_token['type']).to eq('Client')
      end
    end

    context 'with invalid details' do
      it 'returns an error' do
        post '/api/v1/auth', params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
        json_response = response.parsed_body

        expect(json_response['error']).to be_present
      end
    end
  end
end
