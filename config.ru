require_relative 'config/environment'
require 'rollbar/middleware/rack'

use Rollbar::Middleware::Rack if Hanami.env?(:production)

run Hanami.app
