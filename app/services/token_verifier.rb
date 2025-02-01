class TokenVerifier
  ERROR_MAP = {
    missing: [AuthenticationErrors::InvalidTokenError, :missing],
    invalid: [AuthenticationErrors::InvalidTokenError, :invalid],
    format: [AuthenticationErrors::InvalidTokenError, :invalid_format],
    expired: [AuthenticationErrors::ExpiredTokenError, :expired],
    user_not_found: [AuthenticationErrors::AuthenticationError, :user_not_found]
  }.freeze

  def self.call(token)
    validate_presence!(token)

    decoded_token = decode_token!(token)
    validate_token_structure!(decoded_token)

    validate_expiration!(decoded_token)

    find_user!(decoded_token[:user_id])
  end

  def self.validate_presence!(token)
    raise_invalid_token(:missing) if token.blank?
  end

  def self.decode_token!(token)
    JsonWebToken.decode(token) || raise_invalid_token(:invalid)
  end

  def self.validate_token_structure!(decoded_token)
    raise_invalid_token(:format) unless decoded_token.is_a?(Hash) && decoded_token.key?(:user_id) && decoded_token.key?(:exp)
  end

  def self.validate_expiration!(decoded_token)
    return if decoded_token[:exp].to_i >= Time.now.to_i

    raise_invalid_token(:expired)
  end

  def self.find_user!(user_id)
    User.find_by(id: user_id) || raise_invalid_token(:user_not_found)
  end

  def self.raise_invalid_token(type)
    error_class, message_key = ERROR_MAP[type]
    raise error_class, I18n.t("errors.token.#{message_key}")
  end
end
