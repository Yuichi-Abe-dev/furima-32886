require 'rails_helper'

module InputItemInfo
  def input_item_info(user,item)
    # ログインする
    log_in(user)
    # 商品出品ページへ遷移する
    visit new_item_path
    # 添付する画像を定義する
    image_path = Rails.root.join('public/images/400x400_01.png')
    #画像の投稿
    attach_file('item[image]', image_path, make_visible: true)
    #フォームに情報を入力
    fill_in 'item-name', with: item.name
    fill_in 'item-info', with: item.description
    select 'レディース', from: 'item-category'
    select '新品、未使用', from: 'item-sales-status'
    select '着払い(購入者負担)', from: 'item-shipping-fee-status'
    select '北海道', from: 'item-prefecture'
    select '1〜2日で発送', from: 'item-scheduled-delivery'      
    fill_in 'item-price', with: item.price
    #出品ボタンが表示されるようスクロールする
    execute_script('window.scrollBy(0,10000)')
  end
end