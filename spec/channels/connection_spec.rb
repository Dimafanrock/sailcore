require 'rails_helper'

RSpec.describe ApplicationCable::Connection, type: :channel do
  let(:user) { create(:user) }
  let(:valid_token) { JsonWebToken.encode(user_id: user.id) }
  let(:invalid_token) { 'invalid.token.string' }

  it 'successfully connects with a valid token' do
    connect "/cable?token=#{valid_token}"
    expect(connection.current_user).to eq(user)
  end

  it 'rejects connection with an invalid token' do
    expect { connect "/cable?token=#{invalid_token}" }
      .to raise_error(ActionCable::Connection::Authorization::UnauthorizedError)
  end

  it 'rejects connection when no token is provided' do
    expect { connect "/cable" }
      .to raise_error(ActionCable::Connection::Authorization::UnauthorizedError)
  end
end
