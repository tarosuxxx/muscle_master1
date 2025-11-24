class Admin::PostsController < ApplicationController
  def index
    @posts = Post.includes(:user)
                    .left_joins(:likes, :comments) 
                    .select('posts.*, COUNT(likes.id) AS likes_count, COUNT(comments.id) AS comments_count')
                    .group('posts.id') 
                    .order(created_at: :desc)
    @total_posts_count = Post.count
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    
    flash[:notice] = "投稿ID #{@post.id} を削除しました。"
    redirect_to admin_posts_path
  end
end
