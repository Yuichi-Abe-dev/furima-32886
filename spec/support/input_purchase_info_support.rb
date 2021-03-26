require 'rails_helper'

module InputPurchaseInfo
  def input_purchase_info(user, purchase)
     # ログインする
     log_in(user)
     # 他のユーザーの商品詳細ページへ遷移する
     visit item_path(purchase.item_id)
     # 購入
     click_on('購入画面に進む')
     # 購入ページへ遷移することを確認
     expect(current_path).to eq(item_purchases_path(purchase.item_id))
     # フォームに情報を入力
     fill_in 'card-number', with: '4242424242424242'
     fill_in 'card-exp-month', with: '05'
     fill_in 'card-exp-year', with: '30'
     fill_in 'card-cvc', with: '123'
     fill_in 'postal-code', with: purchase.postal_code
     # 入力フォームが表示されるようスクロールする
     execute_script('window.scrollBy(0,10000)')
     select '神奈川県', from: 'prefecture'
     fill_in 'city', with: purchase.municipalities
     fill_in 'addresses', with: purchase.address_line1
     fill_in 'building', with: purchase.address_line2
     fill_in 'phone-number', with: "#{purchase.phone_number}"
     # 購入ボタンが表示されるようスクロールする
     execute_script('window.scrollBy(0,10000)')
  end
end
