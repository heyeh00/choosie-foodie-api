Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'login', to: 'sessions#login', as: :login
      resources :events, only: %i[index create show] do
        resources :event_restaurants, only: %i[show]
      end
      resources :restaurant_picks, only: %i[create]
    end
  end
end
