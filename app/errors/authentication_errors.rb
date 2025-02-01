module AuthenticationErrors
  class AuthenticationError < StandardError; end
  class ExpiredTokenError < AuthenticationError; end
  class InvalidTokenError < AuthenticationError; end
end
