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
require 'devise'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SailCore
  class Application < Rails::Application
    # Initialize configuration defaults for the originally generated Rails version.
    config.load_defaults 7.1

    # API mode: No view rendering, minimal middleware
    config.api_only = false
    config.autoloader = :zeitwerk

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
    config.eager_load_paths += %W[
      #{Rails.root.join('app/services')}
      #{Rails.root.join('app/lib')}
      #{Rails.root.join('app/errors')}
      #{Rails.root.join('app/controllers/concerns')}
    ]

    config.autoload_paths += config.eager_load_paths

    # Require all concerns to avoid NameErrors
    Rails.root.glob('app/controllers/concerns/**/*.rb').each { |file| require file }

    # ActionCable settings
    config.action_cable.mount_path = '/cable'
    config.action_cable.url = ENV.fetch('CABLE_URL', 'ws://localhost:3000/cable')
    config.action_cable.allowed_request_origins = ['http://localhost:3000']

    # Cache store
    config.cache_store = :redis_cache_store, { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/1') }
  end
end
