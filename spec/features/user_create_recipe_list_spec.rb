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
end
