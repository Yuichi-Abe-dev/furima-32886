class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :shipping_date
  belongs_to :user
  # Purchaseテーブル作成後にコメントアウトを外す
  # has_one :purchase
  has_one_attached :image
  with_options presence: true do
    validates :image
    validates :name
    validates :description
    with_options numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 } do
      validates :price
    end
    with_options numericality: { other_than: 1 } do
      validates :category_id
      validates :condition_id
      validates :postage_id
      validates :prefecture_id
      validates :shipping_date_id
    end
end
