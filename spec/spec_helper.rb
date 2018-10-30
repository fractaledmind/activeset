require 'simplecov_helper'

require 'bundler'
Bundler.require :default, :development

Combustion.initialize! :active_record

require 'bundler/setup'
require 'ostruct'
require 'csv'
require 'active_set'

Dir[File.expand_path('support/**/*.rb', __dir__)].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = 'random'

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    begin
      FactoryBot.find_definitions
    rescue FactoryBot::DuplicateDefinitionError
    end
  end
end
