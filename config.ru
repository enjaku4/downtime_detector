require_relative 'config/environment'

use Airbrake::Rack::Middleware if Hanami.env?(:production)

run Hanami.app
