require 'rails_helper'

feature 'User removes recipe from recipe list' do
  scenario 'successfully' do
    user = User.create!(email: 'user@mail.com', password: 'password', role: :user)
    recipe_list = user.recipe_lists.create!(name: 'Minhas receitas')
    recipe_type = RecipeType.create!(name: 'Prato principal')
    recipe = user.recipes.create!(title: 'Farofa', cook_time: 12,
                                  ingredients: 'ingredientes',
                                  instructions: 'instruções', recipe_type: recipe_type)
    ListRecipeRelation.create!(recipe_list: recipe_list, recipe: recipe)

    login_as user
    visit root_path
    click_on 'Minhas listas'
    click_on 'Minhas receitas'
    click_on 'Remover'

    expect(page).to have_content 'Receita removida com sucesso'
    expect(page).not_to have_content 'Farofa'
    expect(page).to have_content 'Nenhuma receita inclusa nessa lista'
    expect(recipe_list.recipes.count).to eq 0
  end
end
