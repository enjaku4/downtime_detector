# Configure your routes here
# See: https://guides.hanamirb.org/routing/overview
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
require 'sidekiq/web'

root to: 'web_addresses#index'

resources :web_addresses, except: [:index, :edit, :update]

resource :user, only: [:update]

mount Sidekiq::Web, at: '/sidekiq' if Hanami.env?(:development)