source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.3'

# 🔹 **Core Rails Dependencies**
gem 'rails', '~> 7.0'
gem 'pg', '~> 1.5', '>= 1.5.6' # PostgreSQL database
gem 'puma', '~> 6.4', '>= 6.4.2' # Web Server
gem 'rack-cors' # CORS support for APIs
gem 'tzinfo-data' # Timezone handling
gem "jbuilder", "~> 2.13"
gem "tailwindcss-rails"

# 🔹 **Authentication & Authorization**
gem 'devise', '~> 4.9'
gem 'devise_token_auth' # Token-based authentication for APIs
gem 'jwt'

# 🔹 **File Uploads & Processing**
gem 'carrierwave', '~> 2.0'
gem 'carrierwave-aws', '~> 1.3' # AWS S3 integration
gem 'mini_magick', '~> 4.11' # Image processing

# 🔹 **Business Logic & State Management**
gem 'active_interaction', '~> 5.3' # Service objects for business logic
gem 'acts_as_list', '~> 1.1' # Ordered lists
gem 'acts_as_votable' # Likes & Ratings

# 🔹 **Admin Panel**
gem "avo", ">= 3.2"
gem 'sprockets-rails' # Option 1 (Classic Rails assets)
gem 'paper_trail' # Audit logs for models

# 🔹 **Background Jobs & Caching**
gem 'redis', '~> 5.1' # Redis for caching & jobs
gem 'sidekiq' # Background job processing (better than ActiveJob)

# 🔹 **API Documentation**
gem 'swagger-blocks' # Swagger API documentation

# 🔹 **Frontend & Asset Pipeline**
gem 'sassc', '2.1.0' # SCSS compiler
gem 'turbolinks', '~> 5.2', '>= 5.2.1' # Faster page loads
gem 'jsbundling-rails' # Recommended alternative to Webpacker in Rails 7
gem 'cssbundling-rails' # Manage CSS with Tailwind/SASS/PostCSS

# 🔹 **Security & Error Monitoring**
gem 'sentry-rails' # Sentry error tracking
gem 'sentry-ruby' # Sentry SDK

# 🔹 **Performance & Code Quality**
gem 'rubocop-performance', require: false
gem 'rubocop-rails', require: false

# 🔹 **Testing & Development**
group :development, :test do
  gem 'rspec-rails', '~> 6.1', '>= 6.1.1' # RSpec for testing
  gem 'rspec-sonarqube-formatter', '~> 1.5', require: false # RSpec formatter for SonarQube
  gem 'factory_bot_rails' # Test data generation
  gem 'faker' # Fake data generator
  gem 'shoulda-matchers', '~> 6.1' # Model validation testing
  gem 'simplecov', require: false # Code coverage reports
  gem 'timecop', '~> 0.9.8' # Time travel in tests
  gem 'webmock' # Mock external HTTP requests in tests
  gem 'byebug', platforms: %i[mri mingw x64_mingw] # Debugging
  gem 'rswag-api'
  gem 'rswag-ui'
  gem 'rswag-specs'
end

group :development do
  gem 'letter_opener_web' # Email preview in browser
  gem 'listen', '~> 3.9' # File change listener
  gem 'spring' # Rails preloader
  gem 'spring-watcher-listen', '~> 2.1' # Spring auto-reload
  gem 'web-console', '~> 4.2', '>= 4.2.1' # Debugging console in browser
  gem "bootsnap", "~> 1.18" # Boot-time optimization
end

group :test do
  gem 'rails-controller-testing' # Controller testing support
end

gem "importmap-rails", "~> 2.1"
