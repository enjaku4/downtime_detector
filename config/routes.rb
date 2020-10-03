Rails.application.routes.draw do
  root to: 'pages#home'

  resource :session, only: [:create, :destroy]
end
