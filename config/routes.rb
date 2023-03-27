Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  #get 'posts', to: 'items#index'
end
