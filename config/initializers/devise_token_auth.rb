DeviseTokenAuth.setup do |config|
  config.change_headers_on_each_request = false
  config.token_lifespan = 2.weeks
  config.token_cost = Rails.env.test? ? 4 : 10
  config.max_number_of_devices = 10
  config.batch_request_buffer_throttle = 5.seconds
  config.omniauth_prefix = '/omniauth'
  config.check_current_password_before_update = :password
  config.enable_standard_devise_support = true
  config.send_confirmation_email = true
end
