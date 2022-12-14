Rails.application.routes.draw do
  # namespace :api do
  #   namespace :v1 do
  #     get 'restaurants/index'
  #   end
  # end
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'login', to: 'sessions#login', as: :login
      get 'cuisines', to: 'events#generate_cuisine_list', as: :cuisines
      get 'event_result/:id', to: 'events#event_result', as: :event_result
      get 'events/users/:id', to: 'events#index', as: :events
      get 'event_attendees/:id', to: 'events#event_attendees', as: :event_attendees
      post 'users/:id/attach_avatar', to: 'users#attach_avatar', as: :attach_avatar
      resources :events, only: %i[create show update] do
        resources :event_restaurants, only: %i[index]
      end
      resources :restaurant_picks, only: %i[create]
      resources :restaurants, only: %i[index]
      resources :users, only: %i[show update]
    end
  end
end
