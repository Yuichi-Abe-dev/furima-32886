require 'rails_helper'

RSpec.describe "商品出品", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
  end
  context '出品画面への遷移' do
    it 'ログインユーザーは商品投稿ページへ遷移できる' do
      # トップページに遷移する
      # 商品出品ページへ遷移する
    end
    it 'ログインユーザーでないと投稿画面へ遷移ができない' do
      # トップページに遷移する
      # 商品出品ページへ遷移を試みる
      # ログインページへ遷移する
    end
  end
end
