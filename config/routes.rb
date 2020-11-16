Rails.application.routes.draw do
  root to: 'tasks#index'
  controller :sessions do
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
  end
  controller :users do
    namespace :admin do #urlに/admin、ヘルパーメソッドにadmin_がつくようになっている
      resources :users
    end
  end
  controller :tasks do
    resources :tasks #resourcesメソッドは全てのアクションに関するルーティングを一括で設定してくれる
  end
end
