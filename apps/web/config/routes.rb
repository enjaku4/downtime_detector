# Configure your routes here
# See: https://guides.hanamirb.org/routing/overview
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }

root to: 'session#new'

resource :session, only: [:create, :destroy]
resources :web_addresses, except: [:edit, :update]
