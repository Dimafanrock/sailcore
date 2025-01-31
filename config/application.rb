# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_cable/engine'
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SailCore
  class Application < Rails::Application
    # Initialize configuration defaults for the originally generated Rails version.
    config.load_defaults 7.1

    # API mode: No view rendering, minimal middleware
    config.api_only = true

    # Enable CORS for API requests (if needed)
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*' # Change this in production
        resource '*', headers: :any, methods: %i[get post put patch delete options head]
      end
    end

    # Enable session storage for Rails Admin & Devise Token Auth
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore

    # Required middleware for RailsAdmin
    config.middleware.use ActionDispatch::Flash
    config.middleware.use Rack::MethodOverride

    # Don't generate system test files.
    config.generators.system_tests = nil

    # Auto-load paths
    config.eager_load_paths << Rails.root.join('app/services')
    config.eager_load_paths << Rails.root.join('app/lib')
    config.autoload_paths << Rails.root.join('app/services')
    config.autoload_paths << Rails.root.join('app/lib')
  end
end
