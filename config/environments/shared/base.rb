Rails.application.configure do
  config.enable_reloading = false
  config.active_storage.service = :local
  config.action_mailer.perform_caching = false
  config.action_controller.raise_on_missing_callback_actions = true
  config.active_support.disallowed_deprecation = :raise
  config.active_support.disallowed_deprecation_warnings = []
end
