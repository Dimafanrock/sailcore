Devise.setup do |config|
  config.mailer_sender = 'no-reply@example.com'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = %i[http_auth token_auth]
  config.reconfirmable = false
  config.expire_all_remember_me_on_sign_out = true
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
end
