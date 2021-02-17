module LogInSupport
  def log_in(user)
    visit new_user_session_path
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
    # ヘッダーにカーソルを合わせるとニックネームが表示されることを確認する
    expect(
      find('.nav').hover
    ).to have_content(@user.nickname)
    # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
    expect(page).to have_no_content('新規登録')
    expect(page).to have_no_content('ログイン')
  end
end