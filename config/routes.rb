Rails.application.routes.draw do
  use_doorkeeper
  namespace :api do
    namespace :v1 do
      post 'github/hook', to: 'github#hook'
    end
  end
end
