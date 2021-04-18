# frozen_string_literal: true

require 'active_record'
require 'dotenv'
require 'yaml'
require 'erb'
require 'pg'

require 'app/services/checkout'
require 'app/models/product'

Dotenv.load

def db_configuration
  db_configuration_file_path = File.join(File.expand_path('..', __dir__), 'db', 'config.yml')
  db_configuration_result = ERB.new(File.read(db_configuration_file_path)).result

  YAML.safe_load(db_configuration_result, aliases: true)
end

ActiveRecord::Base.establish_connection(db_configuration['development'])

module RubyShoppingCart
  class Error < StandardError; end
  # Your code goes here...
end
