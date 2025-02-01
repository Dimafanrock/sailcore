Devise.setup do |config|
  require 'devise/orm/active_record'

  config.mailer_sender = 'no-reply@sailcore.com'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = %i[http_auth token_auth]
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other
  config.allow_unconfirmed_access_for = nil
end
