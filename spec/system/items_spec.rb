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
      # priceを空にする
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

RSpec.describe '商品情報編集', type: :system do
  before do
    @item = FactoryBot.create(:item)
  end
  context '編集画面への遷移ができない時' do
    it '非ログインユーザーは編集画面へ遷移できない' do
      # 商品出品ページへ遷移する
      visit edit_item_path(@item.id)
      # ログインページへ遷移することを確認
      expect(current_path).to eq(new_user_session_path)
    end
    it '商品を出品したユーザーでないと編集画面へ遷移ができない' do
      @user = FactoryBot.create(:user)
      # 商品を出品したユーザーとは別のユーザーがログインする
      log_in(@user)
      # 商品情報編集ページへ遷移する
      visit edit_item_path(@item.id)
      # トップページへ遷移することを確認
      expect(current_path).to eq(root_path)
    end
  end
  context '編集画面から詳細ページへの遷移' do
    it '編集画面からもどるボタンで詳細ページへ遷移できる' do
      # itemを出品したユーザーでサインインする
      log_in(@item.user)
      # 商品情報編集ページへ遷移する
      visit edit_item_path(@item.id)
      # もどるボタンの存在を確認
      expect(page).to have_content('もどる')
      # もどるボタンをクリックする
      click_on('もどる')
      # 商品詳細ページに戻ってくることを確認する
      expect(current_path).to eq(item_path(@item.id))
    end
  end
  context '商品情報を編集できる時' do
    it '商品を出品したユーザーは自身の商品の編集ができる' do
      # 商品情報を編集
      edit_item_info(@item)
      # 出品ボタンが表示されるようスクロールする
      execute_script('window.scrollBy(0,10000)')
      # モデルのカウントが変更されないことを確認
      expect do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(0)
      # 商品詳細ページに戻ってくることを確認する
      expect(current_path).to eq(item_path(@item.id))
      # トップページには先ほど変更した内容の商品情報が存在することを確認する
      expect(page).to have_content("#{@item.name}編集")
      expect(page).to have_content("#{@item.description}編集")
      expect(page).to have_content('メンズ')
      expect(page).to have_content('未使用に近い')
      expect(page).to have_content('送料込み(出品者負担)')
      expect(page).to have_content('青森県')
      expect(page).to have_content('2〜3日で発送')
      expect(page).to have_content(@item.price.to_s)
      expect(page).to have_selector('img')
    end
  end
  context '商品情報を編集できない時' do
    it 'nameが空欄の場合は編集に失敗する' do
      # 商品情報を編集
      edit_item_info(@item)
      # nameを空にする
      fill_in 'item-name', with: ''
      # 編集失敗時のエラーメッセージの定義
      error_message = "Name can't be blank"
      # 編集失敗時にエラーメッセージが表示されることの確認
      test_edit_failure(@item, error_message)
    end
    it 'descriptionが空欄の場合は編集に失敗する' do
      # 商品情報を編集
      edit_item_info(@item)
      # descriptionを空にする
      fill_in 'item-info', with: ''
      # 編集失敗時のエラーメッセージの定義
      error_message = "Description can't be blank"
      # 編集失敗時にエラーメッセージが表示されることの確認
      test_edit_failure(@item, error_message)
    end
    it 'categoryで「---」を選択した場合は編集に失敗する' do
      # 商品情報を編集
      edit_item_info(@item)
      # 「---」を選択する
      select '---', from: 'item-category'
      # 編集失敗時のエラーメッセージの定義
      error_message = 'Category must be other than 1'
      # 編集失敗時にエラーメッセージが表示されることの確認
      test_edit_failure(@item, error_message)
    end
    it 'conditionで「---」を選択した場合は編集に失敗する' do
      # 商品情報を編集
      edit_item_info(@item)
      # 「---」を選択する
      select '---', from: 'item-sales-status'
      # 編集失敗時のエラーメッセージの定義
      error_message = 'Condition must be other than 1'
      # 編集失敗時にエラーメッセージが表示されることの確認
      test_edit_failure(@item, error_message)
    end
    it 'postageで「---」を選択した場合は編集に失敗する' do
      # 商品情報を編集
      edit_item_info(@item)
      # 「---」を選択する
      select '---', from: 'item-shipping-fee-status'
      # 編集失敗時のエラーメッセージの定義
      error_message = 'Postage must be other than 1'
      # 編集失敗時にエラーメッセージが表示されることの確認
      test_edit_failure(@item, error_message)
    end
    it 'prefectureで「---」を選択した場合は編集に失敗する' do
      # 商品情報を編集
      edit_item_info(@item)
      # 「---」を選択する
      select '---', from: 'item-prefecture'
      # 編集失敗時のエラーメッセージの定義
      error_message = 'Prefecture must be other than 1'
      # 編集失敗時にエラーメッセージが表示されることの確認
      test_edit_failure(@item, error_message)
    end
    it 'shipping_dateで「---」を選択した場合は編集に失敗する' do
      # 商品情報を編集
      edit_item_info(@item)
      # 「---」を選択する
      select '---', from: 'item-scheduled-delivery'
      # 編集失敗時のエラーメッセージの定義
      error_message = 'Shipping date must be other than 1'
      # 編集失敗時にエラーメッセージが表示されることの確認
      test_edit_failure(@item, error_message)
    end
    it 'priceが空欄の場合は編集に失敗する' do
      # 商品情報を編集
      edit_item_info(@item)
      # priceを空にする
      fill_in 'item-price', with: ''
      # 編集失敗時のエラーメッセージの定義
      error_message = "Price can't be blank"
      # 編集失敗時にエラーメッセージが表示されることの確認
      test_edit_failure(@item, error_message)
    end
    it 'priceが全角数字の場合は編集に失敗する' do
      # 商品情報を編集
      edit_item_info(@item)
      fill_in 'item-price', with: '１００００'
      # 編集失敗時のエラーメッセージの定義
      error_message = 'Price is not a number'
      # 編集失敗時にエラーメッセージが表示されることの確認
      test_edit_failure(@item, error_message)
    end
    it 'priceに文字列が含まれる場合は編集に失敗する' do
      # 商品情報を編集
      edit_item_info(@item)
      fill_in 'item-price', with: 'a1000'
      # 編集失敗時のエラーメッセージの定義
      error_message = 'Price is not a number'
      # 編集失敗時にエラーメッセージが表示されることの確認
      test_edit_failure(@item, error_message)
    end
    it 'priceが300より小さい場合は編集に失敗する' do
      # 商品情報を編集
      edit_item_info(@item)
      fill_in 'item-price', with: '299'
      # 編集失敗時のエラーメッセージの定義
      error_message = 'Price must be greater than or equal to 300'
      # 編集失敗時にエラーメッセージが表示されることの確認
      test_edit_failure(@item, error_message)
    end
    it 'priceが9999999より大きい場合は編集に失敗する' do
      # 商品情報を編集
      edit_item_info(@item)
      fill_in 'item-price', with: '100000000'
      # 編集失敗時のエラーメッセージの定義
      error_message = 'Price must be less than or equal to 9999999'
      # 編集失敗時にエラーメッセージが表示されることの確認
      test_edit_failure(@item, error_message)
    end
  end
end

RSpec.describe '商品情報削除', type: :system do
  before do
    @item = FactoryBot.create(:item)
  end
  context '削除ができない時' do
    it 'ログインしていないユーザーの場合、商品詳細ページには削除ボタンが表示されない' do
      # 商品詳細ページへ遷移する
      visit item_path(@item.id)
      # 削除ボタンが存在しないことを確認
      expect(page).to have_no_content('削除')
    end
    it '出品者ではないログインユーザーの場合、商品詳細ページには削除ボタンが表示されない' do
      @user = FactoryBot.create(:user)
      # 商品を出品したユーザーとは別のユーザーがログインする
      log_in(@user)
      # 商品情報編集ページへ遷移する
      visit item_path(@item.id)
      # 削除ボタンが存在しないことを確認
      expect(page).to have_no_content('削除')
    end
  end
  context '削除ができる時' do
    it '出品者の場合、出品した商品を削除することができる' do
      # itemを出品したユーザーでサインインする
      log_in(@item.user)
      # 商品詳細ページへ遷移する
      visit item_path(@item.id)
      # 削除ボタンの存在を確認
      expect(page).to have_content('削除')
      # 削除ボタンをクリックするとItemモデルのカウントが減ること確認
      expect{
        click_on('削除')
      }.to change { Item.count }.by(-1)
      # 削除後にトップページに遷移したことを確認する
      expect(current_path).to eq(root_path)
      # トップページに遷移する
      visit root_path
      # トップページには先ほど削除した内容の商品が存在しないことを確認する
      expect(page).to have_no_content("#{@item.name}")
      expect(page).to have_no_content("#{@item.price}")
      expect(page).to have_no_content("#{@item.postage.name}")
    end
  end
end