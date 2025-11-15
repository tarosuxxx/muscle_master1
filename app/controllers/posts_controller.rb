class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show] 
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy] 

  def index
    @posts = Post.all.order(created_at: :desc)
  end
  
  def new
    @post = current_user.posts.build
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: '投稿が完了しました！'
    else
      flash.now[:alert] = "投稿に失敗しました。"
      render :new, status: :unprocessable_entity 
    end
  end
  
  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: '投稿を更新しました。'
    else
      flash.now[:alert] = "更新に失敗しました。"
      render :edit, status: :unprocessable_entity 
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: '投稿を削除しました。'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def correct_user
    unless @post.user == current_user
      redirect_to posts_path, alert: "他のユーザーの投稿は編集・削除できません。"
    end
  end

  def post_params
    params.require(:post).permit(:content, :video_file) 
  end
end
