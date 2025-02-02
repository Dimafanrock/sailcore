require 'rails_helper'

RSpec.describe JsonWebToken do
  let(:payload) { { user_id: 1 } }
  let(:token) { described_class.encode(payload) }

  describe '.encode' do
    it 'returns a JWT token as a string' do
      expect(token).to be_a(String)
      expect(token.split('.').size).to eq(3)
    end
  end

  describe '.decode' do
    it 'decodes a valid token and returns payload' do
      decoded_payload = described_class.decode(token)
      expect(decoded_payload[:user_id]).to eq(1)
    end

    it 'returns nil for an invalid token' do
      expect(described_class.decode('invalid.token')).to be_nil
    end

    it 'returns nil for a blank token' do
      expect(described_class.decode(nil)).to be_nil
    end
  end
end
