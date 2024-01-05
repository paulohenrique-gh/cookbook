class RecipeListsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :edit,
                                            :recipes_index, :remove_recipe]
  before_action :authorize_user, only:[:new, :create, :edit,
                                       :recipes_index, :remove_recipe]

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

  def recipes_index
    @recipe_list = RecipeList.find(params[:id])
  end

  def remove_recipe
    relation = ListRecipeRelation.find_by(recipe_list: params[:id], recipe: params[:recipe_id])
    relation.destroy!
    redirect_to recipes_recipe_list_path(params[:id]), notice: 'Receita removida com sucesso'
  end

  private

  def recipe_list_params
    params.require(:recipe_list).permit(:name)
  end

  def authorize_user
    redirect_to root_path unless current_user == RecipeList.find(params[:id]).user
  end
end
