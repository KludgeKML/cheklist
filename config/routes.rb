Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'github/webhook', to: 'github#webhook'
      get 'users', to: 'user#index'
    end
  end

  root to: 'homepage#index'
end
