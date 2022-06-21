class PostsController < ApplicationController
  # ログインしている人だけが投稿を行えるように[authenticate_user!]を使用
  before_action :authenticate_user!, except: :index

  # 他人に編集,削除ができないようした（投稿者自身が編集ができるようにした)
  before_action :correct_user_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
  end

  def create
    @post = Post.new(post_params.merge(user_id: current_user.id))
    if @post.save
      flash[:notice] = "新規レビューしました"
      redirect_to :posts
    else
      render "posts"
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params.merge(user_id: current_user.id))
      flash[:notice] = "レビューを更新しました"
      redirect_to :posts
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "レビューを削除しました"
    redirect_to :posts
  end

  private

  def post_params
    params.require(:post).permit(:content, :nickname, :user_id, :cook_id)
  end

  # 投稿者自身が編集できるように設定
  def correct_user_post
    @post = Post.find(params[:id])
    @user = @post.user_id
    redirect_to(posts_path) unless @user == current_user.id
  end
end
