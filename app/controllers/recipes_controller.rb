class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]

  def index
    @q = Recipe.ransack(params[:q])
    @recipes = @q.result(distinct: true).includes(:user).page(params[:page]).order("updated_at desc").per(6)
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
     redirect_to recipe_path(@recipe), notice: "投稿に成功しました。"
    else 
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    if @recipe.user != current_user
      redirect_to recipes_path(@recipe), alert:"不正なアクセスです。"
    end
  end

  def update
     @recipe = Recipe.find(params[:id])
     if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe), notice: "更新に成功しました。"
     else
      render :edit, status: :unprocessable_entity
     end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect_to recipes_path
  end

  private
  def recipe_params
    params.require(:recipe).permit(:title,:material, :body, :image)
  end

end
