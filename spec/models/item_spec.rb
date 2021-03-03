require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end
    context '商品の保存がうまくいくとき' do
      it '全てのカラムの値が存在していれば保存できること' do

      end

    end
    context '商品の保存がうまくいかないとき' do
      it 'imageが空では保存できないこと' do

      end

      it 'nameが空では保存できないこと' do

      end

      it 'descriptionが空では保存できないこと' do

      end

      it 'category_idが空では保存できないこと' do

      end

      it 'condition_idが空では保存できないこと' do

      end

      it 'postage_idが空では保存できないこと' do

      end

      it 'prefecture_idが空では保存できないこと' do

      end

      it 'shipping_date_idが空では保存できないこと' do

      end

      it 'が空では保存できないこと' do

      end

      it 'priceが空では保存できないこと' do

      end
    end
  end
end
