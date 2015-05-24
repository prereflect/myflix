Myflix::Application.routes.draw do
  resources :videos, only: [:index, :show]
  resources :categories, only: :show
end
