source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.3'

# 🔹 Core Rails Dependencies
gem 'rails', '~> 7.0'
gem 'pg', '~> 1.5', '>= 1.5.6' # PostgreSQL database
gem 'puma', '~> 6.4', '>= 6.4.2' # Web Server
gem 'rack-cors' # Cross-Origin Resource Sharing (CORS) support
gem 'tzinfo-data' # Timezone handling

# 🔹 Authentication & Authorization
gem 'devise'
gem 'devise_token_auth' # Token-based authentication for APIs

# 🔹 File Uploads
gem 'carrierwave', '~> 2.0'
gem 'carrierwave-aws', '~> 1.3' # AWS S3 integration for CarrierWave
gem 'mini_magick', '~> 4.11' # Image processing

# 🔹 Business Logic & State Management
gem 'active_interaction', '~> 5.3' # Service objects & business logic
gem 'acts_as_list', '~> 1.1' # Ordered lists in ActiveRecord
gem 'acts_as_votable' # Likes & Ratings

# 🔹 Admin Panel
gem 'rails_admin', '~> 3.1', '>= 3.1.2' # Admin dashboard
gem 'paper_trail' # Audit logs for models

# 🔹 Background Jobs & Caching
gem 'redis', '~> 5.1' # Redis for caching & jobs

# 🔹 API Documentation
gem 'swagger-blocks' # Swagger API documentation

# 🔹 Frontend & Asset Pipeline
gem 'sassc', '2.1.0' # SCSS compiler
gem 'turbolinks', '~> 5.2', '>= 5.2.1' # Faster page loads
gem 'webpacker', '~> 5.4', '>= 5.4.4' # Webpack asset management

# 🔹 Security & Error Monitoring
gem 'sentry-rails' # Sentry error tracking
gem 'sentry-ruby' # Sentry SDK

# 🔹 Performance & Code Quality
gem 'rubocop-performance', require: false
gem 'rubocop-rails', require: false

# 🔹 Testing & Development
group :development, :test do
  gem 'rspec-rails', '~> 6.1', '>= 6.1.1' # RSpec for testing
  gem 'rspec-sonarqube-formatter', '~> 1.5', require: false # RSpec formatter for SonarQube
  gem 'factory_bot_rails' # Test data generation
  gem 'faker' # Fake data generator
  gem 'shoulda-matchers', '~> 6.1' # Model validation testing
  gem 'simplecov', require: false # Code coverage reports
  gem 'timecop', '~> 0.9.8' # Time travel in tests
  gem 'webmock' # Mock external HTTP requests in tests
end

group :development do
  gem 'byebug', platforms: %i[mri mingw x64_mingw] # Debugging
  gem 'letter_opener_web' # Email preview in browser
  gem 'listen', '~> 3.9' # File change listener for reloading
  gem 'spring' # Rails preloader
  gem 'spring-watcher-listen', '~> 2.1' # Spring auto-reload
  gem 'web-console', '~> 4.2', '>= 4.2.1' # Debugging console in browser
end

group :test do
  gem 'rails-controller-testing' # Controller testing support
end

gem "bootsnap", "~> 1.18", :group => :development
