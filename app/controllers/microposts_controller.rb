class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:show, :create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "マイクロポストを作成しました!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def show
    @micropost = Micropost.find(params[:id])
    @comment = Comment.new
    @user = User.find_by(id: @micropost.user_id)
  end

  def destroy
    @micropost.destroy
    flash[:success] = "マイクロポストを削除しました!"
    redirect_to root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
