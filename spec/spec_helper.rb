require 'simplecov'
require 'simplecov_json_formatter'
require 'webmock/rspec'

SimpleCov.start 'rails' do
  add_filter { |source_file| source_file.lines.count < 5 }
  add_filter '/models/concerns/docs'
  add_filter '/controllers/concerns/docs'
  add_filter '/controllers/api/v1/apidocs_controller.rb'

  add_group 'Services', 'app/services'
  add_group 'Uploaders', 'app/uploaders'
  add_group 'Validators', 'app/validators'
  add_group 'Interactions', 'app/interactions'
  add_group 'Tasks', 'lib/tasks'
end

SimpleCov.formatter = SimpleCov::Formatter::JSONFormatter if ENV['COVERAGE'] == 'JSON'
WebMock.disable_net_connect!(allow_localhost: true)
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.formatter = 'documentation'
  config.add_formatter('RspecSonarqubeFormatter', 'out/test-report.xml')
end
