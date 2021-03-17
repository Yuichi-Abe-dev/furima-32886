class ItemPurchase
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :municipalities, :address_line1, :address_line2, :phone_number, :purchase_id
end