# README


## usersテーブル

|Column    |Type  |Options    |
| -------- | ---- | --------- |
|nickname  |string|null: false|
|email     |string|null: false, unique: true|
|password  |string|null: false|
|first_name|string|null: false|
|last_name |string|null: false|
|birthday  |date  |null: false|


### Association
- has_many :items
- has_many :purchases
