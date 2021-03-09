require 'rails_helper'
describe ItemsController, type: :request do
  before do
    @item = FactoryBot.create(:item)
  end
  describe 'GET #index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get root_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに出品済みの商品の画像が存在する' do
      get root_path
      expect(response.body).to include(@item.image.id.to_s)
    end
    it 'indexアクションにリクエストするとレスポンスに出品済みの商品の名前が存在する' do
      get root_path
      expect(response.body).to include(@item.name)
    end
    it 'indexアクションにリクエストするとレスポンスに出品済みの商品の価格が存在する' do
      get root_path
      expect(response.body).to include(@item.price.to_s)
    end
    it 'indexアクションにリクエストするとレスポンスに出品済みの商品の配送料の負担が存在する' do
      get root_path
      expect(response.body).to include(@item.postage.name)
    end
  end
end
