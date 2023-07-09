Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do

    namespace :first do
      resources :potatos, only: [:show]
    end

    namespace :second do
      resources :potatos, only: [:show]
    end

  end
end
