class Admin::UsersController < ApplicationController
  def index
    @users = User.all.order(created_at: :desc) 
  end

  def destroy
    @user = User.find(params[:id])
    if @user.is_admin? && @user == current_user
      redirect_to admin_users_path, alert: "あなた自身のアカウントを削除することはできません。"
      return
    end

    @user.destroy
    
    flash[:notice] = "#{@user.name} を強制退会させました。"
    redirect_to admin_users_path
  end
end
