class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "アカウントの有効化に成功しました"
      redirect_to user
    else
      flash[:danger] = "有効化が完了できてないためアカウントを有効化できませんでした"
      redirect_to root_url
    end
  end
end
