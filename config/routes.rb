Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'usersrails/registrations',
    passwords: 'usersrails/passwords'
  }
  
  root to: 'home#page'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    post 'usersrails/guest_sign_in', to: 'usersrails/sessions#guest_sign_in'
  end
  post '/home/guest_sign_in', to: 'home#guest_sign_in'
  
  #検索
  resources :cooks do
    collection do
      get 'search'
    end
  end
  
  #お気に入り済みの料理を表示
  resources :users, only: [:show] do
    get :likes, on: :collection
  end
  
  resources :cooks
  resources :posts
  
  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
  
end
