Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'github/hook', to: 'github#hook'
    end
  end
end
