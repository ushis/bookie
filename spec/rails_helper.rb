require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

# Enable Coveralls on CI builds
if ENV.fetch('CI', false)
  require 'coveralls'
  Coveralls.wear!('rails')
end

require_relative '../config/environment'
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'
require 'webmock/rspec'
require 'sidekiq/testing'

# Load all support modules
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

# Inline all background jobs
Sidekiq::Testing.inline!

# Disable all remote connections
WebMock.disable_net_connect!(allow: [
  -> (uri) { uri.host == URI.parse(ENV.fetch('S3_ENDPOINT')).host },
  -> (uri) { uri.host == URI.parse(ENV.fetch('ELASTICSEARCH_URL')).host },
  -> (uri) { uri.host == URI.parse(ENV.fetch('SELENIUM_URL')).host },
  -> (uri) { uri.host == ENV.fetch('CAPYBARA_HOST') },
])

# Configure remote chrome driver
Capybara.register_driver(:chrome) do |app|
  Capybara::Selenium::Driver.new(app, {
    browser: :remote,
    url: ENV.fetch('SELENIUM_URL'),
    desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome,
  }).tap { |driver|
    driver.browser.file_detector = -> (args) {
      str = args.first.to_s
      str if File.exist?(str)
    }
  }
end

# Configure Capybara
Capybara.configure do |config|
  config.default_driver = :chrome
  config.server_host = ENV.fetch('CAPYBARA_HOST')
  config.server_port = ENV.fetch('CAPYBARA_PORT')
  config.app_host = "http://#{Socket.gethostname}:#{ENV.fetch('CAPYBARA_PORT')}/"
end

RSpec.configure do |config|
  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!

  # Include feature helper in feature tests
  config.include FeatureHelper, type: :feature

  config.before(:suite) {
    Bookie::Search.create_indices(force: true)
    DatabaseCleaner.clean_with(:truncation)
  }

  config.after(:suite) {
    Bookie::Search.delete_indices
  }

  config.before(:each) {
    DatabaseCleaner.strategy = :transaction
  }

  config.before(:each, type: :feature) {
    DatabaseCleaner.strategy = :truncation
  }

  config.before(:each) {
    WebMock.reset!
    DatabaseCleaner.start
  }

  config.append_after(:each) {
    DatabaseCleaner.clean
  }
end
