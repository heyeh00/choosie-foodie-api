Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api, defaults: { format: :json } do
    namespace :v1, do
      post 'login', to: 'sessions#login', as: :login

      resources :users, only: %i[create show update] do
        resources :bookings, only: %i[index create destroy]
    end
  end
end
