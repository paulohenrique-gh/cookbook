Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  get 'user/recipes', to: 'recipes#user_recipes'
  resources :recipe_types, only: %i[new create index show]
  resources :recipes, only: %i[new create edit update show]
end
