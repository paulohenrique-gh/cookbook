Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  resources :recipe_types, only: %i[new create index show]
  resources :recipes, only: %i[new create edit update show]
  resources :recipe_lists, only: %i[index new create edit update]

  namespace :api do
    namespace :v1 do
      get :search, to: 'recipes#search'
    end
  end
end
