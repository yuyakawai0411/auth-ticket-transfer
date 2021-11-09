Rails.application.routes.draw do
  resources :users, only: [:index, :show] do
    resources :tickets, only: [:index, :show, :create, :destroy] do
      resources :transitions, only: [:index, :show, :create]
    end
  end
end
