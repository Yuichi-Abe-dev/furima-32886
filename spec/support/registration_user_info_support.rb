module RegistrationUserInfo
  def registration_user_info(user)
    # トップページに移動する
    visit root_path
    # トップページにサインアップページへ遷移するボタンがあることを確認する
    expect(page).to have_content('新規登録')
    # 新規登録ページへ移動する
    visit new_user_registration_path
    # ユーザー情報を入力する
    fill_in "nickname", with: user.nickname
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    fill_in "password-confirmation", with: user.password_confirmation
    fill_in "last-name", with: user.last_name
    fill_in "first-name", with: user.first_name
    fill_in "last-name-kana", with: user.last_name_kana
    fill_in "first-name-kana", with: user.first_name_kana
    select "2000", from: "user_birthday_1i"
    select "10", from: "user_birthday_2i"
    select "10", from: "user_birthday_3i"
  end
end