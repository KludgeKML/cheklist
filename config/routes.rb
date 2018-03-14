Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'github/webhook', to: 'github#webhook'
      get 'users', to: 'user#index'
    end
  end

  # omniauth callback for GitHub user authentication
  get '/auth/:provider/callback', to: 'session#create'

  root to: 'homepage#index'
end
