class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:create]
  before_action :set_comment_and_post, only: [:destroy]

  def create
    @comment = @post.comments.build(comment_params) 
    @comment.user = current_user
    
    if @comment.save
      # コメントが成功した場合、非同期処理用のレスポンスも考慮
      respond_to do |format|
        format.html { redirect_to @post, notice: "コメントを投稿しました！" }
        format.js # create.js.erbを期待
      end
    else
      # エラー時はリダイレクト先の投稿詳細ページでflash[:alert]を表示
      flash[:alert] = @comment.errors.full_messages.to_sentence
      redirect_to @post 
    end
  end


  # コメント削除 (DELETE /posts/:post_id/comments/:id)
  def destroy
    
    if authorized_to_delete?
      @comment.destroy
      
      respond_to do |format|
        format.html { redirect_to @post, notice: 'コメントを削除しました。' }
        format.js # destroy.js.erbを期待
      end
    else
      respond_to do |format|
        format.html { redirect_to @post, alert: '削除権限がありません。' }
        format.js { head :forbidden } # 権限がない場合は403エラーを返す
      end
    end
  end


  private

  # 権限チェックメソッド
  def authorized_to_delete?
    @comment.user == current_user || # コメント投稿者本人
    @post.user == current_user     || # 親となる投稿の投稿者
    current_user.try(:is_admin?)       # 管理者 (Userモデルにis_admin?メソッドを定義していることを想定)
  end

  # Postを取得する共通処理
  def set_post
    @post = Post.find(params[:post_id])
  end

  # CommentとPostを取得する共通処理
  def set_comment_and_post
    @comment = Comment.find(params[:id])
    @post = @comment.post 
  end

  # ストロングパラメータ
  def comment_params
    params.require(:comment).permit(:content)
  end
end