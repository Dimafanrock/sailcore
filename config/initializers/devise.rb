# frozen_string_literal: true

Devise.setup do |config|
  # Mailer sender for Devise emails
  config.mailer_sender = 'no-reply@sailcore.com'

  # Use ActiveRecord ORM
  require 'devise/orm/active_record'

  # Authentication keys
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]

  # Skip storing user session (since we're using API-based auth)
  config.skip_session_storage = %i[http_auth token_auth]

  # Require password confirmation for security
  config.reconfirmable = true

  # Expire all "remember me" tokens on sign out
  config.expire_all_remember_me_on_sign_out = true

  # Password length
  config.password_length = 6..128

  # Email validation regex
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  # Reset password within 6 hours
  config.reset_password_within = 6.hours

  # HTTP method for sign-out
  config.sign_out_via = :delete

  # Respond with proper HTTP status for Turbo & Hotwire
  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other
end
