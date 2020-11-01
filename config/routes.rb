Rails.application.routes.draw do
  if Rails.env.development?
    require 'sidekiq/web'
    require 'sidekiq-scheduler/web'

    mount Sidekiq::Web => '/sidekiq'
  end

  constraints lambda { |request| request.session[:user_id] } do
    root to: 'web_addresses#index'
  end

  root to: 'pages#home'

  resource :session, only: [:create, :destroy]
  resources :web_addresses, only: [:index, :new, :create, :destroy]
  resources :users, only: [] do
    collection do
      patch :update_email
      patch :delete_email
    end
  end
end
