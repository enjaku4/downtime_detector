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

mount Sidekiq::Web, at: '/sidekiq' if Hanami.env?(:development)