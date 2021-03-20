class ItemPurchase
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :municipalities, :address_line1, :address_line2, :phone_number, :token
  #, :purchase_id

  with_options presence: true do
    validates :municipalities, :address_line1, :token
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :phone_number, format: { with: /\A\d{10}$|^\d{11}\z/ }
  end

  def save
    # 購入情報を保存
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    # 住所の情報を保存
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, municipalities: municipalities, address_line1: address_line1, address_line2: address_line2, phone_number: phone_number, purchase_id: purchase.id)
  end
end