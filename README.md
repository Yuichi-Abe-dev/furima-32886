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
|user_id      |references   |null: false|
|purchase_id  |references   |null: false|



### Association
- belongs_to :user
- has_one :purchase

## purchasesテーブル
|Column      |Type         |Options    |
| --------   | ----        | --------- |
|user_id     |references   |null: false|
|item_id     |references   |null: false|
|address_id  |references   |null: false|

### Association
- belongs_to :user
- belongs_to :item
- has_one :address
