Rails.application.routes.draw do
  mount Attachinary::Engine => "/attachinary"
  devise_for :users
  resources :books do
    resources :user_books
  end

  root to: "books#index"
end
