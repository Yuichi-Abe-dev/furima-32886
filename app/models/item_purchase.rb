class ItemPurchase
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :municipalities, :address_line1, :address_line2, :phone_number, :purchase_id

  with_options presence: true do
    validates :municipalities, :address_line1
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :phone_number, format: { with: /\A\d{10}$|^\d{11}\z/ }
  end
end