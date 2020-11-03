Rails.application.routes.draw do
  resources :exchanges
  resources :coupons, only:[:new, :create]
  devise_for :users
  root 'pages#home'
end
