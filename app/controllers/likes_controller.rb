class LikesController < ApplicationController
  before_action :authenticate_user! 

  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.new(post_id: @post.id)
    
    if @like.save
      redirect_to @post, notice: 'いいねしました！'
    else
      redirect_to @post, alert: 'いいねに失敗しました。' 
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = current_user.likes.find_by(post_id: @post.id)
    
    if @like
      @like.destroy
      redirect_to @post, notice: 'いいねを解除しました。'
    else
      redirect_to @post, alert: 'いいね解除に失敗しました。'
    end
  end
end