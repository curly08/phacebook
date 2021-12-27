Rails.application.routes.draw do
  devise_scope :user do
    authenticated :user do
      root 'posts#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  devise_for :users
  resources :posts do
    resources :comments, except: %i[index show]
  end
  resources :users, only: :index
  resources :friendships, only: %i[create destroy]
  resources :likes, only: %i[create destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
