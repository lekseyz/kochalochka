# spec/rails_helper.rb
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

# Abort if running in production
abort('The Rails environment is running in production mode!') if Rails.env.production?

# Requires the gems that are needed for the tests
require 'rspec/rails'
require 'capybara/rspec'
require 'database_cleaner/active_record'
require 'selenium-webdriver'

# Requires supporting ruby files with custom matchers and macros, etc, in spec/support/ and its subdirectories.
# Files in spec/support/ can be automatically required using `config.infer_spec_type_from_file_location!`.
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Configure FactoryBot methods to be used directly in tests
RSpec.configure do |config|
  # Include FactoryBot methods to avoid the need to prefix with FactoryBot.

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true

  # Automatically infer the spec type from file location
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces
  config.filter_rails_from_backtrace!

  # Use FactoryBot for object creation in tests
  config.before(:suite) do
    # Clean the database before running the tests
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    # Ensure database is cleaned between each test
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  # Enable the focus filter to run only focused tests
  config.filter_run_when_matching :focus

  # Seed randomization for tests
  config.order = :random
  Kernel.srand config.seed

  # Allow focused tests to run with :focus
  config.run_all_when_everything_filtered = true
end

# Capybara settings for feature tests
Capybara.configure do |config|
  # The default driver is :rack_test for non-JS tests
  config.default_driver = :rack_test

  # Configure timeout for waiting for elements
  config.default_max_wait_time = 5

  # Configure the app host for Capybara
  config.app_host = 'http://localhost:3000'
end

# Configure the system driver for JS testing (Selenium with Chrome)
Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

# Use selenium_headless for running tests without opening the browser window
Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless') # Run in headless mode
  options.add_argument('--disable-gpu')
  options.add_argument('--no-sandbox')
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

# Set default driver for JS testing
Capybara.javascript_driver = :selenium_chrome_headless

# Configure the system driver to be headless for faster tests
RSpec.configure do |config|
  config.before(:each, type: :system, js: true) do
    driven_by :selenium_chrome_headless
  end
end
