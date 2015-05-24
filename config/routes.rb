Myflix::Application.routes.draw do
  get 'home', to: 'videos#index'

  resources :videos, only: [:index, :show]
  resources :categories, only: :show
end
