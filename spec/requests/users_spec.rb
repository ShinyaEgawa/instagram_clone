require 'rails_helper'

RSpec.describe "User pages", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }

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
  end

    describe "GET #edit" do
      context "許可されたユーザとして" do
        it "正常なレスポンスを返すこと" do
          sign_in_as user
          get edit_user_path(user)
          expect(response).to be_success
          expect(response).to have_http_status "200"
        end
      end

    context "ログインしていないユーザーの場合" do
      it "ログイン画面にリダイレクトすること" do
        get edit_user_path(user)
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_path
      end
    end

    context "アカウントが違うユーザーの場合" do
      it "ホーム画面にリダイレクトすること" do
        sign_in_as other_user
        get edit_user_path(user)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "#update" do
    context "許可されたユーザとして" do
      it "ユーザーを更新できること" do
        user_params = FactoryBot.attributes_for(:user, name: "NewName")
        sign_in_as user
        patch user_path(user), params: { id: user.id, user: user_params }
        expect(user.reload.name).to eq "NewName"
      end
    end

    context "アカウントが違うユーザーの場合" do
      it "ユーザーを更新できないこと" do
        user_params = FactoryBot.attributes_for(:other_user, name: "NewName")
        sign_in_as user
        patch user_path(user), params: { id: user.id, user: user_params }
        expect(user.reload.name).to eq user.name
      end

      it "ホーム画面にリダイレクトすること" do
        user_params = FactoryBot.attributes_for(:user, name: "NewName")
        sign_in_as other_user
        patch user_path(user), params: { id: user.id, user: user_params }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "#destroy" do
    context "許可されたユーザとして" do
      it "ユーザーを削除できること" do
        sign_in_as user
        expect{
          delete user_path(user), params: { id: user.id }
        }.to change(User, :count).by(-1)
      end
    end

    context "アカウントの違うユーザの場合" do
      it "ホーム画面にリダイレクトすること" do
        sign_in_as other_user
        delete user_path(user), params: { id: user.id }
        expect(response).to redirect_to users_path
      end
    end

    context "ゲストとして" do
      it "302レスポンスを返すこと" do
        delete user_path(user), params: { id: user.id }
        expect(response).to have_http_status "302"
      end

      it "サインインページにリダイレクトすること" do
        delete user_path(user), params: { id: user.id }
        expect(response).to redirect_to login_path
      end
    end
  end
end
