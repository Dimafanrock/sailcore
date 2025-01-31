# frozen_string_literal: true

DeviseTokenAuth.setup do |config|
  # Prevent changing authorization headers on every request (better for API)
  config.change_headers_on_each_request = false

  # Set token expiration (2 weeks)
  config.token_lifespan = 2.weeks

  # Reduce token cost for testing (faster test runs)
  config.token_cost = Rails.env.test? ? 4 : 10

  # Set max number of concurrent devices per user
  config.max_number_of_devices = 10

  # Allow batch requests within 5 seconds
  config.batch_request_buffer_throttle = 5.seconds

  # Skip Omniauth (we don't use it)
  config.omniauth_prefix = '/omniauth'

  # Ensure password confirmation is required when updating passwords
  config.check_current_password_before_update = :password

  # Enable standard Devise support for API authentication
  config.enable_standard_devise_support = false

  # Ensure Devise Token Auth sends confirmation emails
  config.send_confirmation_email = true
end
