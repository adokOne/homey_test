Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "projects#index"
  resources :projects do
    post 'change/:status', as: :change_status, to: 'projects#change_status', on: :member
    resources :comments
  end

  resources :users

  resource :profile
end
