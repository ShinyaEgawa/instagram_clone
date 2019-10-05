require 'rails_helper'

RSpec.describe "Remember me", type: :request do
  let(:user) { FactoryBot.create(:user) }

  # 2つのバグのテスト,その1
  context "有効な情報かどうか" do
    it "ログイン中でのみログアウトができること" do
      sign_in_as(user)
      expect(response).to redirect_to user_path(user)

      #初回ログアウトを行う
      delete logout_path
      expect(response).to redirect_to root_path
      expect(session[:user_id]).to eq nil

      #2回目のログアウトを行う
      delete logout_path
      expect(response).to redirect_to root_path
      expect(session[:user_id]).to eq nil
    end
  end
end
