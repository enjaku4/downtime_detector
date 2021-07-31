# Configure your routes here
# See: https://guides.hanamirb.org/routing/overview
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
require 'sidekiq/web'

root to: 'web_addresses#index'

resources :web_addresses, except: [:index, :edit, :update]

resource :user, only: [] do
  collection do
    patch :update_email
    patch :delete_email
  end
end

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == ENV.fetch('BASIC_AUTH_USERNAME') && password == ENV.fetch('BASIC_AUTH_PASSWORD')
end if Hanami.env?(:production)

mount Sidekiq::Web, at: '/sidekiq'