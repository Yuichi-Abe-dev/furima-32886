# README


## usersテーブル

|Column            |Type  |Options    |
| ---------------- | ---- | --------- |
|nickname          |string|null: false|
|email             |string|null: false, unique: true|
|encrypted_password|string|null: false|
|last_name         |string|null: false|
|first_name        |string|null: false|
|last_name_kana    |string|null: false|
|first_name_kana   |string|null: false|
|birthday          |date  |null: false|


### Association
- has_many :items
- has_many :purchases

## itemsテーブル

|Column          |Type         |Options    |
| -------------- | ----        | --------- |
|name            |string       |null: false|
|description     |text         |null: false|
|category_id     |integer      |null: false|
|condition_id    |integer      |null: false|
|postage_id      |integer      |null: false|
|prefecture_id   |integer      |null: false|
|shipping_date_id|integer      |null: false|
|price           |integer      |null: false|
|user            |references   |null: false, foreign_key: true|



### Association
- belongs_to :user
- has_one :purchase

## purchasesテーブル
|Column   |Type         |Options    |
| ------- | ----------- | --------- |
|user     |references   |null: false, foreign_key: true|
|item     |references   |null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item
- has_one :address

## Addressesテーブル
|Column         |Type     |Options    |
| --------      | ----    | --------- |
|postal_code    |string   |null: false|
|prefecture_id  |integer  |null: false|
|municipalities |string   |null: false|
|address_line1  |string   |null: false|
|address_line2  |string   |           |
|phone_number   |integer  |null: false|
|purchase       |references  |null: false, foreign_key: true|

### Association
- belongs_to :purchase
