Rails.application.routes.draw do
  mount Attachinary::Engine => "/attachinary"
  devise_for :users
  resources :books
  resources :user_books

  root to: "books#index"
end
