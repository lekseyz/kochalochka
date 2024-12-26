# spec/spec_helper.rb
RSpec.configure do |config|
  # Enable flags for the tests and add any other configurations here
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # Allow focusing on specific tests
  config.filter_run_when_matching :focus

  # Show full backtrace when running tests
  config.backtrace_inclusion_patterns = [
    /#{Regexp.escape(Dir.pwd)}/
  ]

  # Seed randomization for tests
  config.order = :random
  Kernel.srand config.seed
end
