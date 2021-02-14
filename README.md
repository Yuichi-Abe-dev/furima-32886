# README


## usersテーブル

|Column            |Type  |Options    |
| ---------------- | ---- | --------- |
|nickname          |string|null: false|
|email             |string|null: false, unique: true|
|encrypted_password|string|null: false|
|first_name        |string|null: false|
|last_name         |string|null: false|
|birthday          |date  |null: false|


### Association
- has_many :items
- has_many :purchases

## itemsテーブル

|Column       |Type         |Options    |
| --------    | ----        | --------- |
|image        |ActiveStorage|null: false|
|name         |string       |null: false|
|description  |text         |null: false, unique: true|
|category     |string       |null: false|
|condition    |string       |null: false|
|postage      |string       |null: false|
|prefecture   |string       |null: false|
|shipping_date|date         |null: false|
|price        |int          |null: false|
|user_id      |references   |null: false, foreign_key: true|
|purchase_id  |references   |foreign_key: true            |



### Association
- belongs_to :user
- has_one :purchase

## purchasesテーブル
|Column      |Type         |Options    |
| --------   | ----        | --------- |
|user_id     |references   |null: false, foreign_key: true|
|item_id     |references   |null: false, foreign_key: true|
|address_id  |references   |null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item
- has_one :address

## Addressesテーブル
|Column         |Type     |Options    |
| --------      | ----    | --------- |
|postal_code    |string   |null: false|
|prefecture     |string   |null: false|
|municipalities |string   |null: false|
|address_line1  |string   |null: false|
|address_line2  |string   |           |
|phone_number   |int      |null: false|

### Association
- belongs_to :purchase
