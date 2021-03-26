require 'rails_helper'

RSpec.describe ItemPurchase, type: :model do
  describe '商品購入情報の保存' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @purchase = FactoryBot.build(:item_purchase)
      sleep 0.02 #インスタンス生成時にエラーが発生するため待機処理を実行
      @purchase.user_id = @user.id
      @purchase.item_id = @item.id
    end
    it 'tokenと購入先情報があれば保存ができること' do
      expect(@purchase).to be_valid
    end
    it 'tokenが空では登録できないこと' do
      @purchase.token = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Token can't be blank")
    end
    it 'postal_codeが空では登録できないこと' do
      @purchase.postal_code = ''
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Postal code can't be blank")
    end
    it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
      @purchase.postal_code = '1234567'
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
    end
    it 'prefecture_idが空では保存できないこと' do
      @purchase.prefecture_id = ''
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Prefecture can't be blank", 'Prefecture is not a number')
    end
    it 'prefecture_idが1では保存できないこと' do
      @purchase.prefecture_id = 1
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('Prefecture must be other than 1')
    end
    it 'municipalitiesが空だと保存できないこと' do
      @purchase.municipalities = ''
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Municipalities can't be blank")
    end
    it 'address_line1が空だと保存できないこと' do
      @purchase.address_line1 = ''
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Address line1 can't be blank")
    end
    it 'address_line2は空でも保存できること' do
      @purchase.address_line2 = ''
      expect(@purchase).to be_valid
    end
    it 'phone_numberが空だと保存できないこと' do
      @purchase.phone_number = ''
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Phone number can't be blank")
    end
    it 'phone_numberが半角数字ではないと保存できないこと' do
      @purchase.phone_number = '000-1111-2222'
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('Phone number is invalid. Enter 10 or 11 digit.')
    end
    it 'phone_numberが10桁未満では保存できないこと' do
      @purchase.phone_number = '123456789'
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('Phone number is invalid. Enter 10 or 11 digit.')
    end
    it 'phone_numberが12桁以上では保存できないこと' do
      @purchase.phone_number = '000111122223'
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('Phone number is invalid. Enter 10 or 11 digit.')
    end
    it 'userと紐付いていないと保存できないこと' do
      @purchase.user_id = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("User can't be blank")
    end
    it 'itemと紐付いていないと保存できないこと' do
      @purchase.item_id = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Item can't be blank")
    end
  end
end
