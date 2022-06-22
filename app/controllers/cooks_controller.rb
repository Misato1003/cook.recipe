class CooksController < ApplicationController
  def index
    @cooks = Cook.all
  end

  def new
    @cook = Cook.new
  end

  def create
    @cook = Cook.new(params.require(:cook).permit(:name, :time, :point, :image, :ingredient, :recipe, :target_cook))
    if @cook.save
      flash[:notice] = "料理の新規登録しました"
      redirect_to :cooks
    else
      render "new"
    end
  end

  def show
    @cook = Cook.find(params[:id])
  end

  def edit
    @cook = Cook.find(params[:id])
  end

  def update
    @cook = Cook.find(params[:id])
    if @cook.update(params.require(:cook).permit(:name, :time, :point, :image, :ingredient, :recipe, :target_cook))
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
end
