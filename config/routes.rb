Rails.application.routes.draw do
  resources :users, only: [:index, :show] do
    resources :tickets, only: [:index, :show, :create, :destroy]
  end
end
