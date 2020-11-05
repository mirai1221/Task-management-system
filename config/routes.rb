Rails.application.routes.draw do
  namespace :admin do #urlに/admin、ヘルパーメソッドにadmin_がつくようになっている
    resources :users
  end
  root to: 'tasks#index'
  resources :tasks #resourcesメソッドは全てのアクションに関するルーティングを一括で設定してくれ
end
