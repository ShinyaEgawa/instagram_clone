require 'rails_helper'

RSpec.describe "User pages", type: :request do
  let(:user) { FactoryBot.create(:user) }

  include ActiveJob::TestHelper

  it "パスワードのリセット" do
    perform_enqueued_jobs do
      # メールアドレスが無効の場合
      post password_resets_path, params: { password_reset: { email: "" } }
      expect(response).to render_template(:new)
      # メールアドレスが有効の場合
      post password_resets_path, params: { password_reset: { email: user.email } }
      expect(response).to redirect_to root_path

      # パスワード再設定フォームのテスト
      user = assigns(:user)
      # メールアドレスが無効の場合
      get edit_password_reset_path(user.reset_token, email: "")
      expect(response).to redirect_to root_path
      # メールアドレが有効であるが、トークンが無効の場合
      get edit_password_reset_path('wrong token', email: user.email)
      expect(response).to redirect_to root_path
      # メールアドレスもトークンも有効の場合
      get edit_password_reset_path(user.reset_token, email: user.email)
      expect(response).to render_template(:edit)
      # 無効なパスワードとパスワード確認が入力された場合
      patch password_reset_path(user.reset_token),
        params: { email: user.email,
                  user: { password: "foobaz",
                          password_confirmation: "barquux" }}
      expect(response).to render_template(:edit)
      # パスワードが空の場合
      patch password_reset_path(user.reset_token),
        params: { email: user.email,
                  user: { password: "",
                          password_confirmation: "barquux" }}
        expect(response).to render_template(:edit)
      # 有効なパスワードとパスワード確認が入力された場合
      patch password_reset_path(user.reset_token),
        params: { email: user.email,
                  user: { password: "foobaz",
                          password_confirmation: "foobaz" }}
      expect(session[:user_id]).to eq user.id
      expect(response).to redirect_to user_path(user)
    end
  end
end
