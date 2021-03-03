require 'rails_helper'
describe ItemsController, type: :request do
  before do
    @item = FactoryBot.create(:item)
  end
  describe "GET #index" do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get root_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに出品済みの商品の名前が存在する' do 
      get root_path
      expect(response.body).to include(@item.name)
    end
    it 'indexアクションにリクエストするとレスポンスに出品済みの商品の説明が存在する' do 
      get root_path
      expect(response.body).to include(@item.description)
    end
    it 'indexアクションにリクエストするとレスポンスに出品済みの商品のユーザーIDが存在する' do 
      get root_path
      expect(response.body).to include(@item.user_id.to_s)
    end
  end
end
