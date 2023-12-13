require 'rails_helper'

feature 'Usuário cria lista de receitas' do
  scenario 'a partir da tela inicial' do
    user = User.create!(email: 'user@mail.com', password: 'password', role: :user)

    login_as user
    visit root_path
    click_on 'Minhas listas'
    click_on 'Criar lista'

    expect(page).to have_field 'Nome da lista'
    expect(page).to have_button 'Salvar'
  end

  scenario 'com sucesso' do
    user = User.create!(email: 'user@mail.com', password: 'password', role: :user)

    login_as user
    visit new_recipe_list_path
    fill_in 'Nome da lista', with: 'Minhas receitas'
    click_on 'Salvar'

    expect(page).to have_content 'Lista salva com sucesso'
    expect(user.recipe_lists.count).to eq 1
  end

  scenario 'e deve estar autenticado' do
    visit new_recipe_list_path

    expect(current_path).to eq new_user_session_path
  end
end
