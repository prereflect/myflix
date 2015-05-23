Myflix::Application.routes.draw do
  resources :videos, only: [:index, :show]
end
