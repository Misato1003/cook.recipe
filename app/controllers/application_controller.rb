class ApplicationController < ActionController::Base
  # devise(ユーザー名、プロフィール画像、一言紹介が登録できないため)
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  # 料理の検索ができる
  before_action :cook_search

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :image, :introduction])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :image, :introduction])
  end

  # 料理の検索ができる
  def cook_search
    if params[:q].present?
      @q = Cook.ransack(params[:q])
      @cooks = @q.result(distinct: true)
    else
      params[:q] = { sorts: 'id desc' }
      @q = Cook.ransack(params[:q])
      @cooks = @q.result(distinct: true)
    end
  end

  def cooks
    params.require(:q).permit(:sorts)
  end
end
