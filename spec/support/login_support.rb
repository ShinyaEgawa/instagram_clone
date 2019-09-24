# 新しいモジュールを作成
module LoginSupport
  def valid_login(user)
    visit root_path
    click_link "Log in"
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログインする"
  end
end

# LoginSupportモジュールをincludeする
RSpec.configure do |config|
  config.include LoginSupport
end
