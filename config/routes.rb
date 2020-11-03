Rails.application.routes.draw do
  resources :exchanges
  devise_for :users
  root 'pages#home'
end
