Rails.application.routes.draw do
  devise_for :users
  resources :articles do
    resources :comments do
      patch '/accept', to: 'comments#accept', as: 'accept'
    end
  end
  resources :users
  root 'welcome#index'
  get 'dashboard', to:'dashboard#index',as: 'dashboard'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
