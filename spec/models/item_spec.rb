require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end
    context '商品の保存がうまくいくとき' do
      it '全てのカラムの値が存在していれば保存できること' do
        expect(@item).to be_valid
      end
      it 'priceが300の場合保存できること' do
        @item.price = 300
        expect(@item).to be_valid
      end
      it 'priceが9999999の場合保存できること' do
        @item.price = 9999999
        expect(@item).to be_valid
      end
    end
    context '商品の保存がうまくいかないとき' do
      it 'imageが空では保存できないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'nameが空では保存できないこと' do
        @item.name =''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'descriptionが空では保存できないこと' do
        @item.description =''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'category_idが空では保存できないこと' do
        @item.category_id =''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank", "Category is not a number")
      end
      it 'condition_idが空では保存できないこと' do
        @item.condition_id =''
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank", "Condition is not a number")
      end
      it 'postage_idが空では保存できないこと' do
        @item.postage_id =''
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage can't be blank", "Postage is not a number")
      end
      it 'prefecture_idが空では保存できないこと' do
        @item.prefecture_id =''
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank", "Prefecture is not a number")
      end
      it 'shipping_date_idが空では保存できないこと' do
        @item.shipping_date_id =''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping date can't be blank", "Shipping date is not a number")
      end
      it 'priceが空では保存できないこと' do
        @item.price =''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'userと紐付いていないと保存できないこと' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
      it 'category_idが1では保存できないこと' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end
      it 'condition_idが1では保存できないこと' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end
      it 'postage_idが1では保存できないこと' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end
      it 'prefecture_idが1では保存できないこと' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
      end
      it 'shipping_date_idが1では保存できないこと' do
        @item.shipping_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping date must be other than 1")
      end
      it 'priceが全角数字の場合は保存できないこと' do
        @item.price = '１００００'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it 'priceに文字列が含まれる場合は保存できないこと' do
        @item.price = 'a1000'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it 'priceが300より小さい場合は保存できないこと' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it 'priceが9999999より大きい場合は保存できないこと' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
    end
  end
end
