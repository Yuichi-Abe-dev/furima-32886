require 'rails_helper'

module EditItemInfo
  def edit_item_info(item)
    #itemを出品したユーザーでサインインする
    log_in(item.user)
    # 商品情報編集ページへ遷移する
    visit edit_item_path(item.id)
    #編集前の商品情報がフォームに入力されていることの確認
    expect(
      find('#item-name').value
    ).to eq(item.name)
    expect(
      find('#item-info').value
    ).to eq(item.description)
    expect(
      find('#item-category').value
    ).to eq(item.category_id.to_s)
    expect(
      find('#item-sales-status').value
    ).to eq(item.condition_id.to_s)
    expect(
      find('#item-shipping-fee-status').value
    ).to eq(item.postage_id.to_s)
    expect(
      find('#item-prefecture').value
    ).to eq(item.prefecture_id.to_s)
    expect(
      find('#item-scheduled-delivery').value
    ).to eq(item.shipping_date_id.to_s)
    expect(
      find('#item-price').value
    ).to eq(item.price.to_s)
    # 商品情報の編集
    # 添付する画像を定義する
    image_path = Rails.root.join('public/images/400x400_02.png')
    # 画像の投稿
    attach_file('item[image]', image_path, make_visible: true)
    # フォームに情報を入力
    fill_in 'item-name', with: "#{item.name}編集"
    fill_in 'item-info', with: "#{item.description}編集"
    select 'メンズ', from: 'item-category'
    select '未使用に近い', from: 'item-sales-status'
    select '送料込み(出品者負担)', from: 'item-shipping-fee-status'
    select '青森県', from: 'item-prefecture'
    select '2〜3日で発送', from: 'item-scheduled-delivery'
    fill_in 'item-price', with: item.price
  end
end