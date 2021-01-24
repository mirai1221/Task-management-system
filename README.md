# README

## 開発環境
- Ruby 2.5.1 => 2.6.5
- Rails 5.2.1

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

### label table
|Column   |Type  |Option|
|---------|------|------|
|type  |string|      |
|task_id  |string|      |

### 
![2020/10/27](https://user-images.githubusercontent.com/53572363/97308747-8d582780-18a4-11eb-936f-371f6b0873b8.JPG)

### 機能追加
- Basic認証 本番環境のみで動作するように設定
- 検索機能 (名称と日付)
- タスクステータス機能
- AWSのS3と連携し画像を載せれるようにする
- seedファイル 初期データファイルを設定
- ページネーション
- ソート機能
