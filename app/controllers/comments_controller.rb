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
    @post = @comment.post 
    if @comment.user == current_user || @post.user == current_user
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to @post, notice: 'コメントを削除しました。' }
        format.js 
      end
    else
      respond_to do |format|
        format.html { redirect_to @post, alert: '削除権限がありません。' }
        format.js { head :forbidden } 
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end