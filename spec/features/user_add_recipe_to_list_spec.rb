require 'rails_helper'

feature 'User adds recipe to list' do
  scenario 'com sucesso' do
    user = User.create!(email: 'user@mail.com', password: 'password', role: :user)
    recipe_list = RecipeList.create!(name: 'Minhas receitas', user: user)
    other_recipe_list = RecipeList.create!(name: 'Outras receitas', user: user)

    recipe_type = RecipeType.create!(name: 'Prato principal')
    recipe = Recipe.create!(title: 'Hamburger', cook_time: 10,
                            ingredients: 'hamburguer, pão de hamburguer, queijo',
                            instructions: 'Frite o hamburguer, coloque no pão, coma',
                            recipe_type: recipe_type, user: user)

    login_as user
    visit root_path
    click_on 'Hamburger'
    select 'Minhas receitas', from: 'Minhas listas'
    click_on 'Salvar'

    expect(page).to have_content 'Receita salva'
    expect(recipe_list.recipes.count).to eq 1
  end
end
