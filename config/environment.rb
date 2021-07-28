require 'bundler/setup'
require 'hanami/setup'
require 'hanami/model'
require_relative '../lib/downtime_detector'
require_relative '../apps/web/application'
require_relative '../apps/auth/application'

Hanami.configure do
  mount Auth::Application, at: '/auth'
  mount Web::Application, at: '/'

  model do
    ##
    # Database adapter
    #
    # Available options:
    #
    #  * SQL adapter
    #    adapter :sql, 'sqlite://db/downtime_detector_development.sqlite3'
    #    adapter :sql, 'postgresql://localhost/downtime_detector_development'
    #    adapter :sql, 'mysql://localhost/downtime_detector_development'
    #
    adapter :sql, ENV.fetch('DATABASE_URL')

    ##
    # Migrations
    #
    migrations 'db/migrations'
    schema     'db/schema.sql'
  end

  mailer do
    root 'lib/downtime_detector/mailers'

    # See https://guides.hanamirb.org/mailers/delivery
    delivery :test
  end

  environment :development do
    # See: https://guides.hanamirb.org/projects/logging
    logger level: :debug

    BetterErrors::Middleware.allow_ip!('0.0.0.0/0')
  end

  environment :production do
    logger level: :info, formatter: :json, filter: []

    mailer do
      delivery :smtp, address: ENV.fetch('SMTP_HOST'), port: ENV.fetch('SMTP_PORT')
    end
  end
end
