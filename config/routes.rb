Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks #resourcesメソッドは全てのアクションに関するルーティングを一括で設定してくれる
  
end
