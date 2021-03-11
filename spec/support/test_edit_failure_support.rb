module TestEditFailure
  def test_edit_failure(item, error_message)
    # 出品ボタンが表示されるようスクロールする
    execute_script('window.scrollBy(0,10000)')
    # モデルのカウントが変更されないことを確認
    expect do
      find('input[name="commit"]').click
    end.to change { Item.count }.by(0)
    # 商品詳細ページに戻ってくることを確認する
    expect(current_path).to eq(item_path(item.id))
    # エラーメッセージが表示されることを確認
    expect(page).to have_content(error_message.to_s)
  end
end
