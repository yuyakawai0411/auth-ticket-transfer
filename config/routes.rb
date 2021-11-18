Rails.application.routes.draw do
  namespace :v1 do
    resources :users, only: [:index, :show] do
      resources :tickets, only: [:index, :show] do
        resources :transitions, only: [:index, :show, :create]
      end
    end
    resources :events, only: [:index, :show] do
      resources :tickets, only: [:create]
    end
  end
end
