module LoginSupport
  def valid_login(user)
    visit root_path
    click_link "Log in"
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    click_button "ログインする"
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end
