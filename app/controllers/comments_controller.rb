class CommentsController < ApplicationController

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = "コメントを投稿しました"
      redirect_to micropost_path(@micropost)
    else
      flash[:alert] = "コメントの投稿に失敗しました"
      render "microposts/show"
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
      flash[:success] = "コメントの削除に成功しました"
      redirect_to request.referrer ||root_url
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :picture)
    end
end
