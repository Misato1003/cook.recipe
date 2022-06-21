class CooksController < ApplicationController
  # ログインしている人だけが投稿を行えるように[authenticate_user!]を使用
  before_action :authenticate_user!, except: [:index, :search, :show]
  # 他人に編集,削除ができないようした（投稿者自身が編集ができるようにした)
  before_action :correct_user_cook, only: [:edit, :update, :destroy]
  # 検索
  before_action :set_cook, only: [:show, :edit, :update, :destroy]
  before_action :set_q, only: [:index, :search]

  def index
    @cooks = Cook.all
  end

  def new
    @cook = Cook.new
  end

  def create
    @cook = Cook.new(cook_params.merge(user_id: current_user.id))
    @cook.user_id = current_user.id
    if @cook.save
      flash[:notice] = "料理の新規登録しました"
      redirect_to :cooks
    else
      render "new"
    end
  end

  def show
    @cook = Cook.find(params[:id])
    @post = Post.new
    @posts = Post.where(cook_id: @cook.id)
  end

  def edit
    @cook = Cook.find(params[:id])
  end

  def update
    @cook = Cook.find(params[:id])
    if @cook.update(cook_params.merge(user_id: current_user.id))
      flash[:notice] = "料理の情報を更新しました"
      redirect_to :cooks
    else
      render "edit"
    end
  end

  def destroy
    @cook = Cook.find(params[:id])
    @cook.destroy
    flash[:notice] = "料理を削除しました"
    redirect_to :cooks
  end
  
  # 検索できる(料理)
  def search
    @results = @q.result
  end

  private

  def set_q
    @q = Cook.ransack(params[:q])
  end

  def set_cook
    @cook = Cook.find(params[:id])
  end

  def cook_params
    params.require(:cook).permit(:name, :time, :point, :image, :ingredient, :recipe, :target_cook)
  end

  # 投稿者自身が編集できるように設定
  def correct_user_cook
    @cook = Cook.find(params[:id])
    @user = @cook.user_id
    redirect_to(cooks_path) unless @user == current_user.id
  end
end
