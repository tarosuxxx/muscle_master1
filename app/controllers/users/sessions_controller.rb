# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    # ゲストユーザーを検索し、存在しなければ作成する
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      # 必須項目を適切に設定
      user.name = "ゲストトレーニー" 
      user.introduction = "お試しで利用中です。"
      user.favorite_category = "全身"
      user.role = "guest" 
    end
    
    sign_in user 
    redirect_to posts_path, notice: 'ゲストトレーニーとしてログインしました。' 
  end
end
