# frozen_string_literal: true

ENV['ENVIRONMENT'] ||= 'development'

require 'dotenv'
Dotenv.load(".env.#{ENV.fetch('ENVIRONMENT')}.local", ".env.#{ENV.fetch('ENVIRONMENT')}", '.env')

require 'standalone_migrations'
StandaloneMigrations::Tasks.load_tasks
