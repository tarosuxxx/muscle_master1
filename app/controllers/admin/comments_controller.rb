class Admin::CommentsController < ApplicationController
  # 💡 必要に応じて管理者認証をここに追加 (例: before_action :authenticate_admin!)

  def index
    # 全てのコメントを取得し、新しいものから順に表示します
    @comments = Comment.all.includes(:user, :post).order(created_at: :desc) 
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to admin_comments_path, notice: "コメントを削除しました。"
  end
end