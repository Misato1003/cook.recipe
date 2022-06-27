class ApplicationController < ActionController::Base
  # devise(ユーザー名、プロフィール画像、一言紹介が登録できないため)
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  # 料理の検索ができる
  before_action :cook_search

  # deviseでログイン後、ログインする前のページに行く。
  after_action :store_location

  protected

  # devise　(ユーザー名、プロフィール画像、一言紹介が登録できないため)
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

  # deviseでログイン後、ログインする前にいく
  def store_location
    # ログイン直前のリクエストをセッションに保存
    if request.fullpath != "/users/sign_in" && \
        request.fullpath != "/users/sign_up" && \
        request.fullpath != "/users/password" && \
        !request.xhr?
      session[:previous_url] = request.fullpath
    end
  end

  # ログイン後のリダイレクトをログイン前のページにする場合
  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  # ログアウト後のリダイレクトをログアウト前のページにする場合
  def after_sign_out_path_for(resource)
    session[:previous_url] || root_path
  end
end
