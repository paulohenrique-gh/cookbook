class RecipeListsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit]

  def index
    @lists = current_user.recipe_lists
  end

  def new
    @recipe_list = RecipeList.new
  end

  def create
    @recipe_list = current_user.recipe_lists.build(recipe_list_params)
    @recipe_list.save
    redirect_to recipe_lists_path, notice: 'Lista salva com sucesso'
  end

  def edit
    @recipe_list = RecipeList.find(params[:id])
  end

  def update
    puts params
    @recipe_list = RecipeList.find(params[:id])
    @recipe_list.recipes = Recipe.find(params[:recipe_id])
  end

  private

  def recipe_list_params
    params.require(:recipe_list).permit(:name)
  end
end
