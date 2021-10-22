Rails.application.routes.draw do
  devise_for :users
  resources :articles do

    patch :vote_plus, on: :member
    patch :vote_minus, on: :member
    resources :comments do
      patch '/accept', to: 'comments#accept', as: 'accept'
    end
  end

  root 'welcome#index'
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'

  resources :users do
    get :feed, on: :collection
  end

  resources :relationships, only: [:create, :destroy]

end
