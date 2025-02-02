require 'rails_helper'

RSpec.describe TokenVerifier, type: :service do
  let(:user) { create(:user) }
  let(:valid_token) { JsonWebToken.encode(user_id: user.id, exp: 24.hours.from_now.to_i) }
  let(:expired_token) { JsonWebToken.encode({ user_id: user.id }, 1.hour.ago.to_i) }
  let(:invalid_token) { 'invalid.token.string' }
  let(:token_without_exp) { JWT.encode({ user_id: user.id }, JsonWebToken::SECRET_KEY, 'HS256') }
  let(:token_missing_fields) { JsonWebToken.encode({}) }
  let(:deleted_user_token) { JsonWebToken.encode(user_id: 9999, exp: 24.hours.from_now.to_i) }

  describe '.call' do
    context 'with a valid token' do
      it 'returns the user' do
        expect(TokenVerifier.call(valid_token)).to eq(user)
      end
    end

    context 'with a missing token' do
      it 'raises an InvalidTokenError' do
        expect { TokenVerifier.call(nil) }.to raise_error(
          AuthenticationErrors::InvalidTokenError,
          I18n.t('errors.token.missing')
        )
      end
    end

    context 'with an invalid token' do
      it 'raises an InvalidTokenError' do
        expect { TokenVerifier.call(invalid_token) }.to raise_error(
          AuthenticationErrors::InvalidTokenError,
          I18n.t('errors.token.invalid')
        )
      end
    end

    context 'with a token missing expiration key' do
      it 'raises an InvalidTokenError for invalid format' do
        expect { TokenVerifier.call(token_without_exp) }.to raise_error(
          AuthenticationErrors::InvalidTokenError,
          I18n.t('errors.token.invalid_format')
        )
      end
    end

    context 'with a token missing required fields' do
      it 'raises an InvalidTokenError for invalid format' do
        expect { TokenVerifier.call(token_missing_fields) }.to raise_error(
          AuthenticationErrors::InvalidTokenError,
          I18n.t('errors.token.invalid_format')
        )
      end
    end

    context 'with an expired token' do
      it 'raises an ExpiredTokenError' do
        expect { TokenVerifier.call(expired_token) }.to raise_error(
          AuthenticationErrors::ExpiredTokenError,
          I18n.t('errors.token.expired')
        )
      end
    end

    context 'with a token for a deleted user' do
      it 'raises an AuthenticationError' do
        expect { TokenVerifier.call(deleted_user_token) }.to raise_error(
          AuthenticationErrors::AuthenticationError,
          I18n.t('errors.token.user_not_found')
        )
      end
    end
  end
end
