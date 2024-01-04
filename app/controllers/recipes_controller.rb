class RecipesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]

  def show
    @recipe = Recipe.find(params[:id])
    session["recipe"] = @recipe
  end

  def new
    @recipe = Recipe.new
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      flash[:notice] = t('.success')
      return redirect_to(@recipe)
    end
    flash.now[:alert] = t('.error')
    render :new
  end

  def update
    @recipe = Recipe.find(params[:id])

    return redirect_to @recipe if @recipe.update(recipe_params)

    render :edit
  end

  def add_to_list
    recipe = Recipe.find(session["recipe"]["id"])
    recipe_list = current_user.recipe_lists.find(params[:recipe_list][:id])
    relation = ListRecipeRelation.new(recipe: recipe, recipe_list: recipe_list)
    relation.save
    redirect_to recipe, notice: "Receita salva em #{recipe_list.name}"
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id,
                                   :cook_time, :ingredients,
                                   :instructions)
  end
end
