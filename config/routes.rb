Rails.application.routes.draw do
  resources :exchange, only:[:index] 
  devise_for :users
  root 'pages#home'
end
