Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  resources :recipe_types, only: %i[new create index show]
  resources :recipes, only: %i[new create edit update show] do
    post :add_to_list, to: 'recipes#add_to_list', on: :member
  end
  resources :recipe_lists, only: %i[index new create edit update] do
    get :recipes, to: 'recipe_lists#recipes_index', on: :member
  end

  namespace :api do
    namespace :v1 do
      get :recipes, to: 'recipes#search'
    end
  end
end
