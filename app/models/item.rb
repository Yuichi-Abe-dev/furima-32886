class Item < ApplicationRecord
  belongs_to :user
  #Purchaseテーブル作成後にコメントアウトを外す
  #has_one :purchase
  has_one_attached :image
  validates :name, :description, :category_id, :condition_id, :postage_id, :prefecture_id, :shipping_date_id, :price, presence: true
end