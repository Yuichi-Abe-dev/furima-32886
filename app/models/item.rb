class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :shipping_date
  belongs_to :user
  #Purchaseテーブル作成後にコメントアウトを外す
  #has_one :purchase
  has_one_attached :image
  validates :name, :description, :category_id, :condition_id, :postage_id, :prefecture_id, :shipping_date_id, :price, presence: true
end