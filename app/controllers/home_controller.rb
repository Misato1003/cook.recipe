class HomeController < ApplicationController
  def pages
  end

  # ゲストログイン用
  def guest_sign_in
    user = User.find_or_create_by!(email: 'gest@example.com') do |users|
      users.password = SecureRandom.urlsafe_base64
    end
    sign_in user
    redirect_to root_path, norice: 'ゲストユーザーとしてログインしました'
  end
end
