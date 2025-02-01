require_relative 'shared/base'
require_relative 'shared/logging'

Rails.application.configure do
  config.eager_load = true
  config.consider_all_requests_local = false
  config.force_ssl = true
  config.i18n.fallbacks = true
  config.active_support.report_deprecations = false
  config.active_record.dump_schema_after_migration = false
end
