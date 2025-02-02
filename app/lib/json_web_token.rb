require 'jwt'

class JsonWebToken
  SECRET_KEY = Rails.application.credentials.secret_key_base.freeze
  ALGORITHM = 'HS256'.freeze

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY, ALGORITHM)
  end

  def self.decode(token)
    return nil if token.blank?

    body, = JWT.decode(token, SECRET_KEY, true, { algorithm: ALGORITHM, verify_expiration: false })
    ActiveSupport::HashWithIndifferentAccess.new(body)
  rescue JWT::DecodeError
    nil
  end
end
