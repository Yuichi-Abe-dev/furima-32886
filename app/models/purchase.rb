class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :item
  #Addressテーブル作成後にコメントアウトを外す
  #has_one :address
end
