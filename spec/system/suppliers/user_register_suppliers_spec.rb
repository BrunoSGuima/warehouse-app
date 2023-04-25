require 'rails_helper'

describe "Usuário cadastra um fornecedor" do
  it "a partir do menu" do
    
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar novo fornecedor'
    

    expect(page).to have_field('Nome Fantasia')
    expect(page).to have_field('Razão Social')
    expect(page).to have_field('CNPJ')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Estado')
    expect(page).to have_field('E-mail')
  end

  it "com sucesso" do
    
    visit root_path

    click_on 'Fornecedores'
    click_on 'Cadastrar novo fornecedor'
    fill_in "Nome Fantasia",	with: "teste1"
    fill_in "Razão Social",	with: "teste2"
    fill_in "CNPJ",	with: "teste3" 
    fill_in "Endereço",	with: "teste4" 
    fill_in "Cidade",	with: "teste5" 
    fill_in "Estado",	with: "teste6" 
    fill_in "E-mail",	with: "teste7" 
    click_on 'Enviar'

    expect(page).to have_content 'Fornecedor cadastrado com sucesso!'
    expect(page).to have_content 'teste2'
    expect(page).to have_content 'teste3'
    expect(page).to have_content 'teste4'
    expect(page).to have_content 'teste5'
    expect(page).to have_content 'teste6'
    expect(page).to have_content 'teste7'
  end

  it "com dados incompletos" do
    
    visit root_path

    click_on 'Fornecedores'
    click_on 'Cadastrar novo fornecedor'
    fill_in "Nome Fantasia",	with: ""
    fill_in "Razão Social",	with: ""
    fill_in "CNPJ",	with: "" 
    fill_in "Endereço",	with: "" 
    fill_in "Cidade",	with: "" 
    fill_in "Estado",	with: "" 
    fill_in "E-mail",	with: "" 
    click_on 'Enviar'

    expect(page).to have_content 'Fornecedor não cadastrado.'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'Razão Social não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
  end
    
end