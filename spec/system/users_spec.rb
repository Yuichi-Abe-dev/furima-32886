require 'rails_helper'

RSpec.describe "ユーザーの新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      #新規登録画面に遷移し、ユーザー情報を入力
      registration_user_info(@user)
       # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
       expect{
         find('input[name="commit"]').click
       }.to change { User.count }.by(1)
       # トップページへ遷移したことを確認する
       expect(current_path).to eq(root_path)
       # ヘッダーにカーソルを合わせるとログアウトボタンが表示されることを確認する
       expect(
         find('.nav').hover
       ).to have_content('ログアウト')
       # ヘッダーにカーソルを合わせるとニックネームが表示されることを確認する
       expect(
         find('.nav').hover
       ).to have_content(@user.nickname)
       # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
       expect(page).to have_no_content('新規登録')
       expect(page).to have_no_content('ログイン')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it 'ニックネームが空欄の場合ユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      #新規登録画面に遷移し、ユーザー情報を入力
      registration_user_info(@user)
      # ユーザー情報を入力する
      fill_in "nickname", with: ''
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq('/users')
      #エラーメッセージが表示されることを確認
      expect(page).to have_content("Nickname can't be blank")
    end
    it 'メールアドレスが空欄の場合ユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      #新規登録画面に遷移し、ユーザー情報を入力
      registration_user_info(@user)
      # ユーザー情報を入力する
      fill_in "email", with: ''
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq('/users')
      #エラーメッセージが表示されることを確認
      expect(page).to have_content("Email can't be blank")
    end
    it 'パスワードが空欄の場合ユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      #新規登録画面に遷移し、ユーザー情報を入力
      registration_user_info(@user)
      # ユーザー情報を入力する
      fill_in "password", with: ''
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq('/users')
      #エラーメッセージが表示されることを確認
      expect(page).to have_content("Password can't be blank")
    end
    it 'last_nameが空欄の場合ユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      #新規登録画面に遷移し、ユーザー情報を入力
      registration_user_info(@user)
      # ユーザー情報を入力する
      fill_in "last-name", with: ''
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq('/users')
      #エラーメッセージが表示されることを確認
      expect(page).to have_content("Last name can't be blank")
    end
    it 'first_nameが空欄の場合ユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      #新規登録画面に遷移し、ユーザー情報を入力
      registration_user_info(@user)
      # ユーザー情報を入力する
      fill_in "first-name", with: ''
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq('/users')
      #エラーメッセージが表示されることを確認
      expect(page).to have_content("First name can't be blank")
    end
    it 'last_name_kanaが空欄の場合ユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      #新規登録画面に遷移し、ユーザー情報を入力
      registration_user_info(@user)
      # ユーザー情報を入力する
      fill_in "last-name-kana", with: ''
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq('/users')
      #エラーメッセージが表示されることを確認
      expect(page).to have_content("Last name kana can't be blank")
    end
    it 'first_name_kanaが空欄の場合ユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      #新規登録画面に遷移し、ユーザー情報を入力
      registration_user_info(@user)
      # ユーザー情報を入力する
      fill_in "first-name-kana", with: ''
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq('/users')
      #エラーメッセージが表示されることを確認
      expect(page).to have_content("First name kana can't be blank")
    end
    it '生年月日の年が空欄の場合ユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      #新規登録画面に遷移し、ユーザー情報を入力
      registration_user_info(@user)
      # ユーザー情報を入力する
      select "--", from: "user_birthday_1i"
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq('/users')
      #エラーメッセージが表示されることを確認
      expect(page).to have_content("Birthday can't be blank")
    end
    it '生年月日の月が空欄の場合ユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      #新規登録画面に遷移し、ユーザー情報を入力
      registration_user_info(@user)
      # ユーザー情報を入力する
      select "--", from: "user_birthday_2i"
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq('/users')
      #エラーメッセージが表示されることを確認
      expect(page).to have_content("Birthday can't be blank")
    end
    it '生年月日の日が空欄の場合ユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      #新規登録画面に遷移し、ユーザー情報を入力
      registration_user_info(@user)
      # ユーザー情報を入力する
      select "--", from: "user_birthday_3i"
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq('/users')
      #エラーメッセージが表示されることを確認
      expect(page).to have_content("Birthday can't be blank")
    end
    it 'emailが登録済みの場合、新規登録ができずに新規登録ページへ戻ってくる' do
      @user.save
      #新規登録画面に遷移し、ユーザー情報を入力
      registration_user_info(@user)
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq('/users')
      #エラーメッセージが表示されることを確認
      expect(page).to have_content("Email has already been taken")
    end
    it 'emailが@を含まない場合ユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      #新規登録画面に遷移し、ユーザー情報を入力
      registration_user_info(@user)
      # ユーザー情報を入力する
      fill_in "email", with: 'test.com'
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq('/users/sign_up')
    end
    it 'パスワードが5文字以下の場合ユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      #新規登録画面に遷移し、ユーザー情報を入力
      registration_user_info(@user)
      # ユーザー情報を入力する
      fill_in "password", with: '12345'
      fill_in "password-confirmation", with: '12345'
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq('/users')
      #エラーメッセージが表示されることを確認
      expect(page).to have_content("Password is too short (minimum is 6 characters)")
    end
    it 'passwordとpassword_confirmationが不一致の場合ユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      #新規登録画面に遷移し、ユーザー情報を入力
      registration_user_info(@user)
      # ユーザー情報を入力する
      fill_in "password", with: '123456'
      fill_in "password-confirmation", with: '1234567'
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq('/users')
      #エラーメッセージが表示されることを確認
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
    it 'last_nameが全角（漢字・ひらがな・カタカナ）ではない場合ユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      #新規登録画面に遷移し、ユーザー情報を入力
      registration_user_info(@user)
      # ユーザー情報を入力する
      fill_in "last-name", with: 'test'
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq('/users')
      #エラーメッセージが表示されることを確認
      expect(page).to have_content("Last name 全角文字を使用してください")
    end
    it 'first_nameが全角（漢字・ひらがな・カタカナ）ではない場合ユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      #新規登録画面に遷移し、ユーザー情報を入力
      registration_user_info(@user)
      # ユーザー情報を入力する
      fill_in "first-name", with: 'test'
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq('/users')
      #エラーメッセージが表示されることを確認
      expect(page).to have_content("First name 全角文字を使用してください")
    end
    it 'last_name_kanaが全角（カタカナ）ではない場合ユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      #新規登録画面に遷移し、ユーザー情報を入力
      registration_user_info(@user)
      # ユーザー情報を入力する
      fill_in "last-name-kana", with: 'test'
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq('/users')
      #エラーメッセージが表示されることを確認
      expect(page).to have_content("Last name kana 全角カタカナを使用してください")
    end
    it 'first_name_kanaが全角（カタカナ）ではない場合ユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      #新規登録画面に遷移し、ユーザー情報を入力
      registration_user_info(@user)
      # ユーザー情報を入力する
      fill_in "first-name-kana", with: 'test'
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq('/users')
      #エラーメッセージが表示されることを確認
      expect(page).to have_content("First name kana 全角カタカナを使用してください")
    end
  end
end

RSpec.describe "ユーザーのログイン", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do 
    it '正しい情報を入力すればログインができてトップページに移動する' do
      #新規登録画面に遷移し、ログインする
      log_in(@user)
    end
  end
  context 'ログインができないとき' do 
    it 'メールアドレスが異なる場合、ログインページにとどまる' do
      #新規登録画面に遷移
      visit new_user_session_path
      #ユーザー情報を入力
      fill_in "email", with: ''
      fill_in "password", with: @user.password
      find('input[name="commit"]').click
      #ログインページにとどまることを確認
      expect(current_path).to eq('/users/sign_in')
      #エラーメッセージが表示されていることを確認
      expect(page).to have_content('Invalid Email or password.')
    end
    it 'パスワードが異なる場合、ログインページにとどまる' do
      #新規登録画面に遷移
      visit new_user_session_path
      #ユーザー情報を入力
      fill_in "email", with: @user.email
      fill_in "password", with: ''
      find('input[name="commit"]').click
      #ログインページにとどまることを確認
      expect(current_path).to eq('/users/sign_in')
      #エラーメッセージが表示されていることを確認
      expect(page).to have_content('Invalid Email or password.')
    end
  end
end

RSpec.describe "ユーザーのログアウト", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログアウトができるとき' do 
    it 'ログイン後にログアウトボタンが正常に表示されていればログアウトできる' do
      ##新規登録画面に遷移し、ログインする
      log_in(@user)
      # カーソルを合わせるとログアウトボタンが表示されることを確認する
      expect(
        find('.nav').hover
      ).to have_content('ログアウト')
      #ログアウトボタンを押す
      find('.logout').click
      #トップベージに遷移することを確認
      expect(current_path).to eq(root_path)
      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていることを確認する
      expect(page).to have_content('新規登録')
      expect(page).to have_content('ログイン')
    end
  end
end
