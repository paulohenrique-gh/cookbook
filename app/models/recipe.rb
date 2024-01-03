class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :user
  has_many :list_recipe_relations
  has_many :recipe_lists, through: :list_recipe_relations
  validates :title, :cook_time, :ingredients, :instructions, presence: true
end
