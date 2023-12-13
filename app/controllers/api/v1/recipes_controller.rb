class Api::V1::RecipesController < Api::V1::RecipesController
  def search
    @recipe = Recipe.where('title LIKE ?', params[:query])
  end
end
