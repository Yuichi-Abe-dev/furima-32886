require 'rails_helper'

RSpec.describe "商品購入", type: :system do

  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @purchase = FactoryBot.build(:item_purchase)
    @purchase.item_id = @item.id 
    sleep 0.1
  end
  context '購入ができる時' do
    it 'ログインユーザーは他のユーザが出品した商品を購入できる' do
      @user = FactoryBot.create(:user)
      # 購入情報の入力
      input_purchase_info(@user, @purchase)
      # DBに保存されていることを確認する
      expect do
        find('input[name="commit"]').click
        sleep 1.0
      end.to change { Purchase.count }.by(1)
      # トップページにページに戻ってくることを確認する
      expect(current_path).to eq(root_path)
      # 商品が売切れの表示になったことの確認
      expect(page).to have_content("Sold Out!!")
      # 購入済みの商品詳細ページに遷移しても購入できない
      visit item_path(@purchase.item_id)
      # 購入ボタンが存在しないことを確認
      expect(page).to have_no_content("購入画面に進む")
    end
    it 'address_line2は空でも保存できること' do
      @user = FactoryBot.create(:user)
      #address_line2を空欄にする
      @purchase.address_line2 = ''
      # 購入情報の入力
      input_purchase_info(@user, @purchase)
      # DBに保存されていることを確認する
      expect do
        find('input[name="commit"]').click
        sleep 1.0
      end.to change { Purchase.count }.by(1)
      # トップページにページに戻ってくることを確認する
      expect(current_path).to eq(root_path)
      # 商品が売切れの表示になったことの確認
      expect(page).to have_content("Sold Out!!")
    end
    it 'phone_numberが12桁以上を入力できないため問題なく購入できる' do
      @user = FactoryBot.create(:user)
      #phone_numberが12桁以上にする
      @purchase.phone_number = '000111122223333'
      # 購入情報の入力
      input_purchase_info(@user, @purchase)
      # DBに保存されていることを確認する
      expect do
        find('input[name="commit"]').click
        sleep 1.0
      end.to change { Purchase.count }.by(1)
      # トップページにページに戻ってくることを確認する
      expect(current_path).to eq(root_path)
      # 商品が売切れの表示になったことの確認
      expect(page).to have_content("Sold Out!!")
    end
  end
  context '購入画面へ遷移できない時' do
    it '非ログインユーザーが他のユーザーが出品した商品の購入ページに遷移できない' do
      # 他のユーザーの商品詳細ページへ遷移する
      visit item_path(@purchase.item_id)
      # 購入ボタンが存在しないことを確認
      expect(page).to have_no_content("購入画面に進む")
    end
    it '商品を出品したユーザーは自身の出品した商品の購入ページに遷移できない' do
      # ログインする
      log_in(@item.user)
      # 商品詳細ページへ遷移する
      visit item_path(@item.id)
      # 購入ボタンが存在しないことを確認
      expect(page).to have_no_content("購入画面に進む")
    end
  end
  context '購入ができない時' do
    it 'クレジットカード情報が空の場合は商品購入できない' do
      @user = FactoryBot.create(:user)
      # 購入情報の入力
      input_purchase_info(@user, @purchase)
      # クレジットカード情報の入力
      fill_in 'card-number', with: ''
      # DBに保存されていないことを確認する
      expect do
        find('input[name="commit"]').click
        sleep 1.0
      end.to change { Purchase.count }.by(0)
      # 商品詳細ページに留まることを確認する
      expect(current_path).to eq(item_purchases_path(@purchase.item_id))
      # 商品が売切れの表示にならないことの確認
      expect(page).to have_no_content("Sold Out!!")
      # エラーメッセージの表示の確認
      expect(page).to have_content("Token can't be blank")
    end
    it 'postal_codeが空では商品購入できない' do
      @purchase.postal_code = ''
      error_message = "Postal code can't be blank"
      purchace_failure(@purchase,error_message)
      expect(page).to have_content("Postal code is invalid. Include hyphen(-)")
    end
    it 'postal_codeが半角のハイフンを含んだ正しい形式でない場合商品購入できない' do
      @purchase.postal_code = '1234567'
      error_message = "Postal code is invalid. Include hyphen(-)"
      purchace_failure(@purchase,error_message)
    end
    it 'prefecture_idが1では商品購入できない' do
       # ログインする
     log_in(@user)
     # 他のユーザーの商品詳細ページへ遷移する
     visit item_path(@purchase.item_id)
     # 購入
     click_on('購入画面に進む')
     # 購入ページへ遷移することを確認
     expect(current_path).to eq(item_purchases_path(@purchase.item_id))
     # フォームに情報を入力
      fill_in 'card-number', with: '4242424242424242'
      fill_in 'card-exp-month', with: '05'
      fill_in 'card-exp-year', with: '30'
      fill_in 'card-cvc', with: '123'
      fill_in 'postal-code', with: @purchase.postal_code
      # 入力フォームが表示されるようスクロールする
      execute_script('window.scrollBy(0,10000)')
      select '---', from: 'prefecture'
      fill_in 'city', with: @purchase.municipalities
      fill_in 'addresses', with: @purchase.address_line1
      fill_in 'building', with: @purchase.address_line2
      fill_in 'phone-number', with: "#{@purchase.phone_number}"
      # 購入ボタンが表示されるようスクロールする
      execute_script('window.scrollBy(0,10000)')
      # DBに保存されていないことを確認する
      expect do
        find('input[name="commit"]').click
        sleep 1.0
      end.to change { Purchase.count }.by(0)
      # 商品詳細ページに留まることを確認する
      expect(current_path).to eq(item_purchases_path(@purchase.item_id))
      # 商品が売切れの表示にならないことの確認
      expect(page).to have_no_content("Sold Out!!")
      # エラーメッセージの表示の確認
      expect(page).to have_content("Prefecture must be other than 1")
    end
    it 'municipalitiesが空だと商品購入できない' do
      @purchase.municipalities = ''
      error_message = "Municipalities can't be blank"
      purchace_failure(@purchase,error_message)
    end
    it 'address_line1が空だと商品購入できない' do
      @purchase.address_line1 = ''
      error_message = "Address line1 can't be blank"
      purchace_failure(@purchase,error_message)
    end
    it 'phone_numberが空だと保存できないこと商品購入できない' do
      @purchase.phone_number = ''
      error_message = "Phone number can't be blank"
      purchace_failure(@purchase,error_message)
    end
    it 'phone_numberが半角数字ではないと保存できない商品購入できない' do
      @purchase.phone_number = '000-1111-2222'
      error_message = "Phone number is invalid. Enter 10 or 11 digit."
      purchace_failure(@purchase,error_message)
    end
    it 'phone_numberが10桁未満では商品購入できない' do
      @purchase.phone_number = '123456789'
      error_message = "Phone number is invalid. Enter 10 or 11 digit."
      purchace_failure(@purchase,error_message)
    end
  end
end
