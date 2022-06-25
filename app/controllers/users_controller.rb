class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @cooks = @user.cooks

    likes = Like.where(user_id: current_user.id).pluck(:cook_id)
    @like_list = Cook.find(likes)
  end
end
