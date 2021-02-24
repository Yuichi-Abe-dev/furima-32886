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
  validates :name, :description, :price, presence: true
  with_options presence: true, numericality: { other_than: 1 } do
    validates :category_id
    validates :condition_id
    validates :postage_id
    validates :prefecture_id
    validates :shipping_date_id
  end
end