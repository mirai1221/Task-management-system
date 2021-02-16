# README

## 開発環境
- Ruby 2.5.1 => 2.6.5
- Rails 5.2.1

1.アプリケーション概要　　
　会社内で使用するタスク管理ツールが無い会社をターゲットにした社内で使用するタスク管理アプリケーション

2.アプリケーションで使っている技術
  - インフラ → heroku
  - データベース → PostgreSQL
  - 言語 → Ruby on Rails
  - 画像ストレージ → S3
  - コーディング規約 → RuboCop
  
3.アプリケーションの機能
管理者としてログインする
  - ユーザー登録ができる → admin true

ユーザー(管理者共通機能)としてログインする
  - タスク投稿 →　名称、説明、ステータスが記録できる
  - 検索機能 → ransack(名称と日付)
  - タスクステータス機能 →　未着手・着手中・完了が選択できる
  - タスクソート機能 → ransackのsort_linkヘルパーメソッド
  - 画像投稿機能 →　(画像投稿できる機能はコメントアウトしてます)
  
その他の機能
  - 認証機能　→　Basic認証(本番環境のみで動作するように設定)
  - seedファイル 初期データファイルを設定
  - ページネーション機能 → kaminari  


### users table
|Column   |Type  |Option|
|---------|------|------|
|name　　　|string　　　|null: false|
|email    |string|null: false|
|password_digest |string|null: false|
|admin |boolean|default: false, null: false|
|created_at|datetime|null: false|
|updated_at|datetime|null: false|
|email|index|unique: true|

Association
- has_many :tasks
- has_one_attached :image

### tasks table
|Column   |Type  |Option|
|---------|------|------|
|name  |string|limit: 30, null: false|
|status   |string|      |
|description |text||
|deadline |string|      |
|user_id  |references|null: false,|

Association
- belongs_to :user

### 開発前 画面推移図・ER図
![2020/10/27](https://user-images.githubusercontent.com/53572363/97308747-8d582780-18a4-11eb-936f-371f6b0873b8.JPG)
