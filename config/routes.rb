Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'github/webhook', to: 'github#webhook'
    end
  end
end
