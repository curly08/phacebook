Rails.application.routes.draw do
  devise_scope :user do
    authenticated :user do
      root 'posts#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :posts do
    member do
      delete :delete_photo_attachment
    end
    resources :comments, except: %i[index show]
    get '/comments', to: redirect('/posts/%{post_id}')
  end
  resources :users, only: %i[index show edit update]
  resources :friendships, only: %i[create destroy]
  resources :likes, only: %i[create destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
