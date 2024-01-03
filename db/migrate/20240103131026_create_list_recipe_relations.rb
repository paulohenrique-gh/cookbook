class CreateListRecipeRelations < ActiveRecord::Migration[7.0]
  def change
    create_table :list_recipe_relations do |t|
      t.references :recipe_list, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
