class UsersController < ApplicationController
 before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.with_attached_video.order(created_at: :desc)#.page(params[:page])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'プロフィール情報を更新しました。'
    else
      flash.now[:alert] = 'プロフィールの更新に失敗しました。'
      render :edit, status: :unprocessable_entity
    end
  end

 

  private

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(current_user), alert: '他のユーザーのプロフィールは編集できません。'
    end
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :favorite_category, :profile_image)
  end
end
