require_relative 'config/environment'

use Airbrake::Rack::Middleware

run Hanami.app
