require 'rails_helper'

describe 'Busca de receitas API' do
  context 'GET /api/v1/recipes' do
    it 'returns an array with the correct recipe' do
      user = User.create!(email: 'user@mail.com', password: 'password', role: user)
      recipe_type = RecipeType.create!(name: 'Sobremesa')
      recipe = Recipe.create!(title: 'Pudim', cook_time: 30, recipe_type: recipe_type,
                              ingredients: 'ingredientes', instructions: 'Faça o pudim',
                              user: user)
      other_recipe = Recipe.create!(title: 'Outra receita', cook_time: 15,
                                    recipe_type: recipe_type, ingredients: 'outros ingredientes',
                                    instructions: 'termine de fazer', user: user)

      get '/api/v1/recipes?query=pudim'

      expect(response).to have_http_status 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Array
      expect(json_response.length).to eq 1
      expect(json_response.first['title']).to eq 'Pudim'
      expect(json_response.first['cook_time']).to eq 30
      expect(json_response.first['recipe_type']).to eq 'Sobremesa'
      expect(json_response.first['user']).to eq 'user@mail.com'
    end
  end
end
