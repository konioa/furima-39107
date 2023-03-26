# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birthday           | string | null: false |


### Association

- has_many :items
- has_many :orders

## items テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | -----------                    |
| image         | string     | null: false                    |
| title         | text       | null: false                    |
| description   | integer    | null: false                    |
| condition     | integer    | null: false,                   |
| delivery_cost | integer    | null: false,                   |
| shipping_area | integer    | null: false,                   |
| shipping_date | integer    | null: false,                   |
| price         | integer    | null: false,                   |
| user_id       | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order

# orders テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :payment

# payments テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| postcode   | string     | null: false                    |
| prefecture | integer    | null: false,                   |
| city       | string     | null: false,                   |
| block      | string     | null: false,                   |
| building   | string     |                                |
| phone      | string     | null: false,                   |
| order      | references | null: false, foreign_key: true |

### Association

- belongs_to :order