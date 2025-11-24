class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params) 
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "コメントを投稿しました！"
    else
      flash[:alert] = @comment.errors.full_messages.to_sentence
    end
    redirect_to @post 
  end

 
  def destroy
    @comment = Comment.find(params[:id]) 
    unless @comment.user == current_user
      redirect_to @comment.post, alert: "他のユーザーのコメントは削除できません。"
      return
    end

    @comment.destroy
    flash[:notice] = "コメントを削除しました。"
    redirect_to @comment.post
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end