require 'simplecov'
require 'simplecov_json_formatter'

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
