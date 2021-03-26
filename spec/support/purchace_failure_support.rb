require 'rails_helper'

module PurchaceFailure
  def purchace_failure(purchase,error_message)
      user = FactoryBot.create(:user)
      # 購入情報の入力
      input_purchase_info(user, purchase)
      # DBに保存されていないことを確認する
      expect do
        find('input[name="commit"]').click
        sleep 1.0
      end.to change { Purchase.count }.by(0)
      # 商品詳細ページに留まることを確認する
      expect(current_path).to eq(item_purchases_path(purchase.item_id))
      # 商品が売切れの表示にならないことの確認
      expect(page).to have_no_content("Sold Out!!")
      # エラーメッセージの表示の確認
      expect(page).to have_content(error_message.to_s)
  end
end
