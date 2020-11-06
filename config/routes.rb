Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  namespace :admin do #urlに/admin、ヘルパーメソッドにadmin_がつくようになっている
    resources :users
  end
  root to: 'tasks#index'
  resources :tasks #resourcesメソッドは全てのアクションに関するルーティングを一括で設定してくれ
end
