require 'rails_helper'

feature 'User views recipes in recipe list' do
  scenario 'with multiple recipes added' do
    user = User.create!(email: 'user@mail.com', password: 'password', role: :user)
    recipe_list = RecipeList.create!(name: 'Favoritas', user: user)
    recipe_type = RecipeType.create!(name: 'Prato principal')
    recipe = recipe_list.recipes.create!(title: 'Hamburger', cook_time: 10,
                                         ingredients: 'ingrediente',
                                         instructions: 'instructions',
                                         recipe_type: recipe_type, user: user)
    other_recipe = recipe_list.recipes.create!(title: 'Outra receita',
                                               cook_time: 40,
                                               ingredients: 'ingredientes',
                                               instructions: 'instructions',
                                               recipe_type: recipe_type, user: user)

    login_as user
    visit root_path
    click_on 'Minhas listas'
    click_on 'Favoritas'

    expect(page).to have_content 'Hamburger'
    expect(page).to have_content 'Outra receita'
  end
end
