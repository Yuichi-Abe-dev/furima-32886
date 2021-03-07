require 'rails_helper'

RSpec.describe '商品出品', type: :system do
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
  context '商品出品ができるとき' do
    it '適切な値が入力された場合は商品出品ができる' do
      # 商品出品ページへ遷移し情報を入力
      input_item_info(@user, @item)
      # DBに保存されていることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(1)
      # トップページにページに戻ってくることを確認する
      expect(current_path).to eq(root_path)
    end
  end
  context '商品出品ができないとき' do
    it '画像が添付されていない場合は出品できない' do
      # ログインする
      log_in(@user)
      # 商品出品ページへ遷移する
      visit new_item_path
      # 画像の添付なしでフォームに情報を入力
      fill_in 'item-name', with: @item.name
      fill_in 'item-info', with: @item.description
      select 'レディース', from: 'item-category'
      select '新品、未使用', from: 'item-sales-status'
      select '着払い(購入者負担)', from: 'item-shipping-fee-status'
      select '北海道', from: 'item-prefecture'
      select '1〜2日で発送', from: 'item-scheduled-delivery'
      fill_in 'item-price', with: @item.price
      # 出品ボタンが表示されるようスクロールする
      execute_script('window.scrollBy(0,10000)')
      # DBに保存されないことを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(0)
      # 出品ページへ戻されることを確認する
      expect(current_path).to eq('/items')
      # エラーメッセージが表示されることを確認
      expect(page).to have_content("Image can't be blank")
    end
    it 'nameが空欄の場合は出品できない' do
      # 商品出品ページへ遷移しフォームを入力
      input_item_info(@user, @item)
      # nameを空にする
      fill_in 'item-name', with: ''
      # DBに保存されないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(0)
      # 出品ページへ戻されることを確認する
      expect(current_path).to eq('/items')
      # エラーメッセージが表示されることを確認
      expect(page).to have_content("Name can't be blank")
    end
    it 'descriptionが空欄の場合は出品できない' do
      # 商品出品ページへ遷移しフォームを入力
      input_item_info(@user, @item)
      # descriptionを空にする
      fill_in 'item-info', with: ''
      # DBに保存されないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(0)
      # 出品ページへ戻されることを確認する
      expect(current_path).to eq('/items')
      # エラーメッセージが表示されることを確認
      expect(page).to have_content("Description can't be blank")
    end
    it 'categoryで「---」を選択した場合は出品できない' do
      # 商品出品ページへ遷移しフォームを入力
      input_item_info(@user, @item)
      # 「---」を選択する
      select '---', from: 'item-category'
      # DBに保存されないことを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(0)
      # 出品ページへ戻されることを確認する
      expect(current_path).to eq('/items')
      # エラーメッセージが表示されることを確認
      expect(page).to have_content('Category must be other than 1')
    end
    it 'conditionで「---」を選択した場合は出品できない' do
      # 商品出品ページへ遷移しフォームを入力
      input_item_info(@user, @item)
      # 「---」を選択する
      select '---', from: 'item-sales-status'
      # DBに保存されないことを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(0)
      # 出品ページへ戻されることを確認する
      expect(current_path).to eq('/items')
      # エラーメッセージが表示されることを確認
      expect(page).to have_content('Condition must be other than 1')
    end
    it 'postageで「---」を選択した場合は出品できない' do
      # 商品出品ページへ遷移しフォームを入力
      input_item_info(@user, @item)
      # 「---」を選択する
      select '---', from: 'item-shipping-fee-status'
      # DBに保存されないことを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(0)
      # 出品ページへ戻されることを確認する
      expect(current_path).to eq('/items')
      # エラーメッセージが表示されることを確認
      expect(page).to have_content('Postage must be other than 1')
    end
    it 'prefectureで「---」を選択した場合は出品できない' do
      # 商品出品ページへ遷移しフォームを入力
      input_item_info(@user, @item)
      # 「---」を選択する
      select '---', from: 'item-prefecture'
      # DBに保存されないことを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(0)
      # 出品ページへ戻されることを確認する
      expect(current_path).to eq('/items')
      # エラーメッセージが表示されることを確認
      expect(page).to have_content('Prefecture must be other than 1')
    end
    it 'shipping_dateで「---」を選択した場合は出品できない' do
      # 商品出品ページへ遷移しフォームを入力
      input_item_info(@user, @item)
      # 「---」を選択する
      select '---', from: 'item-scheduled-delivery'
      # DBに保存されないことを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(0)
      # 出品ページへ戻されることを確認する
      expect(current_path).to eq('/items')
      # エラーメッセージが表示されることを確認
      expect(page).to have_content('Shipping date must be other than 1')
    end
    it 'priceが空欄の場合は出品できない' do
      # 商品出品ページへ遷移しフォームを入力
      input_item_info(@user, @item)
      # nameを空にする
      fill_in 'item-price', with: ''
      # DBに保存されないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(0)
      # 出品ページへ戻されることを確認する
      expect(current_path).to eq('/items')
      # エラーメッセージが表示されることを確認
      expect(page).to have_content("Price can't be blank")
    end
    it 'priceが全角数字の場合は出品できない' do
      # 商品出品ページへ遷移しフォームを入力
      input_item_info(@user, @item)
      # nameを空にする
      fill_in 'item-price', with: '１００００'
      # DBに保存されないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(0)
      # 出品ページへ戻されることを確認する
      expect(current_path).to eq('/items')
      # エラーメッセージが表示されることを確認
      expect(page).to have_content('Price is not a number')
    end
    it 'priceに文字列が含まれる場合は出品できない' do
      # 商品出品ページへ遷移しフォームを入力
      input_item_info(@user, @item)
      # nameを空にする
      fill_in 'item-price', with: 'a1000'
      # DBに保存されないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(0)
      # 出品ページへ戻されることを確認する
      expect(current_path).to eq('/items')
      # エラーメッセージが表示されることを確認
      expect(page).to have_content('Price is not a number')
    end
    it 'priceが300より小さい場合は出品できない' do
      # 商品出品ページへ遷移しフォームを入力
      input_item_info(@user, @item)
      # nameを空にする
      fill_in 'item-price', with: '299'
      # DBに保存されないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(0)
      # 出品ページへ戻されることを確認する
      expect(current_path).to eq('/items')
      # エラーメッセージが表示されることを確認
      expect(page).to have_content('Price must be greater than or equal to 300')
    end
    it 'priceが9999999より大きい場合は出品できない' do
      # 商品出品ページへ遷移しフォームを入力
      input_item_info(@user, @item)
      # nameを空にする
      fill_in 'item-price', with: '100000000'
      # DBに保存されないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(0)
      # 出品ページへ戻されることを確認する
      expect(current_path).to eq('/items')
      # エラーメッセージが表示されることを確認
      expect(page).to have_content('Price must be less than or equal to 9999999')
    end
  end
end
