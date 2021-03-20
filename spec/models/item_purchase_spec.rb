require 'rails_helper'

RSpec.describe ItemPurchase, type: :model do
  describe '商品購入情報の保存' do
    before do
      @purchase = FactoryBot.build(:item_purchase)
    end

    it "tokenと購入先情報があれば保存ができること" do
      expect(@purchase).to be_valid
    end

    it "tokenが空では登録できないこと" do
      @purchase.token = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Token can't be blank")
    end

    it "postal_codeが空では登録できないこと" do
      @purchase.postal_code = ''
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Postal code can't be blank")
    end
  end
end
