class LikesController < ApplicationController
  before_action :authenticate_user! 

  def create
    @post = Post.find(params[:post_id])
    like = current_user.likes.build(post_id: @post.id)
    like.save
    
    respond_to do |format|
      format.html { redirect_to @post }
      format.js 
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post_id: @post.id)
    like.destroy
    
    respond_to do |format|
      format.html { redirect_to @post }
      format.js 
    end
  end
end