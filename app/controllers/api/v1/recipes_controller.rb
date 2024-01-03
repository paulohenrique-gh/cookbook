class Api::V1::RecipesController < Api::V1::ApiController
  def search
    recipes = Recipe.where('title LIKE ?', "%#{params[:query]}%").as_json

    recipes.map do |recipe|
      recipe["recipe_type"] = RecipeType.find(recipe["recipe_type_id"]).name
      recipe["user"] = User.find(recipe["user_id"]).email
    end

    render status: 200, json: recipes, except: ["recipe_type_id", "user_id", "id",
                                                "created_at", "updated_at",
                                                "ingredients", "instructions"]
  end
end
