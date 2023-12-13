require 'rails_helper'

describe 'Busca de receitas API' do
  context 'GET /api/v1/search' do
    recipe_type = RecipeType.create!(name: 'Sobremesa')

    get '/api/v1/search/'
  end
end
