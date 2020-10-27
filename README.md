#README

##開発環境
- Ruby 2.5.1p57
- Rails 5.2.

### users table
|Column   |Type  |Option|
|---------|------|------|
|user_name|string|      |
|email    |string|      |
|password |string|      |


### tasks table
|Column   |Type  |Option|
|---------|------|------|
|name  |string|      |
|status   |string|      |
|description |text|null: true|
|deadline |string|      |
|user_id  |string|      |

### label table
|Column   |Type  |Option|
|---------|------|------|
|type  |string|      |
|task_id  |string|      |


![2020/10/27](https://user-images.githubusercontent.com/53572363/97308747-8d582780-18a4-11eb-936f-371f6b0873b8.JPG)
