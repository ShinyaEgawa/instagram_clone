def full_title(page_title)
  # バナータイトル
  base_title = "Ruby on Rails Tutorial Sample App"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end

  # ログインする
  def sign_in_as(user)
  post login_path, params: { session: { email: user.email,
                                      password: user.password } }
  end
end
