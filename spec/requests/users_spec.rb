require 'rails_helper'

RSpec.describe "User pages", type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "GET #new" do
    it "正常なレスポンスを返すこと" do
      get signup_path
      expect(response).to be_success
      expect(response).to have_http_status "200"
    end
  end

  describe "GET #show" do
    context "ログイン済みのユーザーとして" do
      it "正常なレスポンスを返すこと" do
        sign_in_as user
        get user_path(user)
        expect(response).to be_success
        expect(response).to have_http_status "200"
      end
    end

    context "ログインしていないユーザーの場合" do
      it "ログイン画面にリダイレクトすること" do
        get user_path(user)
        expect(response).to redirect_to root_path
      end
    end

    context "アカウントが違うユーザーの場合" do
      before do
        @other_user = FactoryBot.create(:user)
      end

      it "ホーム画面にリダイレクトすること" do
        sign_in_as @other_user
        get user_path(user)
        expect(response).to redirect_to root_path
      end
    end
  end
end
