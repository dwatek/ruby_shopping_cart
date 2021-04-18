# frozen_string_literal: true

ENV['ENVIRONMENT'] ||= 'test'

$LOAD_PATH.unshift File.expand_path('..', __dir__)
require 'database_cleaner/active_record'
require 'dotenv'
require 'factory_bot'
require 'pry'

Dotenv.load(".env.#{ENV.fetch('ENVIRONMENT')}.local", ".env.#{ENV.fetch('ENVIRONMENT')}", '.env')

require 'app/ruby_shopping_cart'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.disable_monkey_patching!

  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
