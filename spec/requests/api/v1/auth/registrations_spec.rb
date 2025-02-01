require 'rails_helper'

RSpec.describe 'API::V1::Auth::Registration', type: :request do
  let(:valid_params) do
    { user: { email: 'client@example.com', name: 'John Doe', nickname: 'johnny' } }
  end

  let(:invalid_email_params) do
    { user: { email: 'invalid', name: 'John Doe' } }
  end

  let(:missing_fields_params) do
    { user: { email: '', name: '' } }
  end

  let(:existing_user) { create(:client, email: 'client@example.com') }
  let(:duplicate_email_params) do
    { user: { email: existing_user.email, name: 'Another User' } }
  end

  subject(:make_request) { post '/api/v1/auth', params: params }

  shared_examples 'an unsuccessful registration' do |expected_errors|
    it 'returns an error response with correct messages' do
      make_request
      expect(response).to have_http_status(:unprocessable_entity)

      json_response = response.parsed_body
      expect(json_response).to include('errors') # Ensure errors key exists
      expect(json_response['errors']).to match_array(expected_errors)
    end
  end

  describe 'POST /api/v1/auth' do
    context 'with valid details' do
      let(:params) { valid_params }

      it 'creates a client and returns structured JSON' do
        expect { make_request }.to change(Client, :count).by(1)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template('api/v1/clients/show')

        json_response = response.parsed_body
        expect(json_response).to include('user') # Ensure user key exists
        expect(json_response['user']['email']).to eq(valid_params[:user][:email])
        expect(json_response['user']['token']).to be_present

        decoded_token = JsonWebToken.decode(json_response['user']['token'])
        expect(decoded_token['user_id']).to be_present
        expect(decoded_token['type']).to eq('Client')
      end
    end

    context 'with invalid email format' do
      let(:params) { invalid_email_params }
      it_behaves_like 'an unsuccessful registration', ["Email is not an email"]
    end

    context 'with missing required fields' do
      let(:params) { missing_fields_params }
      it_behaves_like 'an unsuccessful registration', [
        "Email can't be blank",
        "Name is too short (minimum is 4 characters)"
      ]
    end

    context 'when email is already taken' do
      let(:params) { duplicate_email_params }
      it_behaves_like 'an unsuccessful registration', ["Email has already been taken"]
    end
  end
end
