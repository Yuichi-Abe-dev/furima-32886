require 'rails_helper'

RSpec.describe "商品出品", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
  end
  context '商品出品ページへの遷移' do
    it 'ログインユーザーは商品出品ページへ遷移できる' do
      # ログインする
      log_in(@user)
      # 商品出品ページへ遷移する
      visit new_item_path
      # 商品投稿出品ページへ遷移できることを確認
      expect(current_path).to eq(new_item_path)
    end
    it 'ログインユーザーでないと商品出品ページへ遷移ができずログインページへ遷移する' do
      # 商品出品ページへ遷移を試みる
      visit new_item_path
      # 商品投稿ページではなくログインページへ遷移する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
