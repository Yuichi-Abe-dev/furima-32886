module VerifyRemainUnedit
  def verify_remain_unedit(item)
    # 編集前の商品情報がフォームに入力されていることの確認
    expect_info('#item-name', item.name)
    expect_info('#item-info', item.description)
    expect_info('#item-category', item.category_id.to_s)
    expect_info('#item-sales-status', item.condition_id.to_s)
    expect_info('#item-shipping-fee-status', item.postage_id.to_s)
    expect_info('#item-prefecture', item.prefecture_id.to_s)
    expect_info('#item-scheduled-delivery', item.shipping_date_id.to_s)
    expect_info('#item-price', item.price.to_s)
  end

  def expect_info(find_content, equivalent_content)
    expect(
      find(find_content).value
    ).to eq(equivalent_content)
  end
end
