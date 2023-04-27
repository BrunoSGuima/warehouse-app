require 'rails_helper'

describe "Usuário se autentica" do
  it "com sucesso" do

    visit root_path
    click_on 'Entrar'
    click_on 'Criar Conta'
    fill_in "E-mail",	with: "jessica@email.com"
    fill_in "Senha",	with: "password" 
    fill_in "Confirme sua senha", with: "password"
    click_on "Criar"


    expect(page).to have_content 'jessica@email.com'
    expect(page).to have_content 'Você realizou seu registro com sucesso.'
    expect(page).to have_button 'Sair'
    
  end
end