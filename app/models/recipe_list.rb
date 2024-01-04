class RecipeList < ApplicationRecord
  belongs_to :user
  has_many :list_recipe_relations, dependent: :destroy
  has_many :recipes, through: :list_recipe_relations
end
