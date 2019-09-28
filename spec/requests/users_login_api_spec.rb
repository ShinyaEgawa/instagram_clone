require 'rails_helper'

RSpec.describe "UsersLoginApi", type: :request do

  it "sessions/newにアクセスできること" do
    #ログインページにアクセスします
    get login_path
    expect(response).to have_http_status(:success)
  end

  describe "<sessions#new>" do
    context "ログインに失敗した時" do
      it "フラッシュメッセージの残留をキャッチすること" do
        get login_path
        expect(response).to have_http_status(:success)

        #「email:""」と「password:""」の値を持ってlogin_pathにアクセスします
        # → バリデーションに引っかかりログインできません
        post login_path, params: { session: { email: "", password: "" }}
        expect(response).to have_http_status(:success)

        #flash[:danger]が表示されているかチェックします
        expect(flash[:danger]).to be_truthy

        #Rails Tutorialだと、minitest記述でbe_emptyとありますが、
        #be_emptyで「flash[:danger]のテストを行うとエラーになります。
        #get root_pathに移動前：expect(flash[:danger]).to_not be_empty → GREEN
        #get root_pathに移動前：expect(flash[:danger]).to be_truthy → RED
        #エラーを見ると返り値が"true"だったため、be_truthyとbe_falseyにしています。

        #root_path（別ページ）に移動してflash[:danger]が表示されていないかチェックします
        get root_path
        expect(flash[:danger]).to be_falsey
      end
    end
  end

#8.3.1
 #ログアウト
 describe "<request#destory>" do
   #ユーザーがログインした状態にする
   before do
     #@userにユーザー情報を登録
     @user = FactoryBot.build(:user)
     #User.find_byが呼ばれた際に@userを返す
     allow(User).to receive(:find_by).and_return(@user)
     #ログイン完了
   end

   context "ユーザーがログアウトした時" do
     it "falseを返すこと" do

       delete logout_path

       #be_falsey → nilか空白であればfalseです
       expect(response).to have_http_status "302"
       expect(session[:user_id]).to be_falsey # => nil
     end
   end
 end

#9
describe "<sessions#destroy>" do
    context "2つのバグのテストその2" do
      before do
        @user = FactoryBot.build(:user)
      end
      it "2番目のウィンドウでログアウトする場合" do
        get login_path
        post login_path, params: { session: { email: @user.email, password: "password" } }

        expect(response).to have_http_status "200"
        redirect_to(@user)
        #expect(response).to redirect_to("users/show")
        expect(response).to have_http_status "200"

        delete logout_path
        expect(response).to redirect_to(root_path)

        # 2番目のウィンドウでログアウトをクリックするユーザーをシミュレートする
        delete logout_path
        follow_redirect!

        expect(response).to have_http_status "200"
      end
    end
  end
end
