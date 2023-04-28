require 'rails_helper'

describe "Usuário edita um galpão" do

  it "a partir da página de detalhes" do

    #Arrange
    #Criar um galpão no banco de dados
    user = User.create!(email: 'bruno@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city:'Rio de Janeiro', area: 60_000, cep: '20000-000', 
                                description:'Galpão do aeroporto do Rio', address: 'Avenida Atlantica, 10')

    #Act
    login_as(user)
    #abrir a app
    visit root_path
    #visitar o galpão
    click_on 'Rio'
    #clicar em editar
    click_on 'Editar'
    #trocar algo no formulario

    #submeter

    #Assert
    # garantir que o formulário aparece
    expect(page).to have_content('Editar Galpão')
    expect(page).to have_field('Nome', with: 'Rio')
    expect(page).to have_field('Descrição')
    expect(page).to have_field('Código')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('CEP')
    expect(page).to have_field('Área')
  end

  it "com sucesso" do

    #Arrange
    #Criar um galpão no banco de dados
    user = User.create!(email: 'bruno@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city:'Rio de Janeiro', area: 60_000, cep: '20000-000', 
                                description:'Galpão do aeroporto do Rio', address: 'Avenida Atlantica, 10')

    #Act
    login_as(user)
    visit root_path
    #visitar o galpão
    click_on 'Rio'
    #clicar em editar
    click_on 'Editar'
    fill_in "Nome",	with: "Galpão do Rio"
    fill_in "Área",	with: "65000"
    fill_in "CEP",	with: "22000-000"
    click_on 'Enviar'
    

    #Assert
    expect(page).to  have_content "Galpão atualizado com sucesso!"
    expect(page).to  have_content "Nome: Galpão do Rio"
    expect(page).to  have_content "Área: 65000 m2"
    expect(page).to  have_content "CEP: 22000-000"
  end

  it "mantém os campos obrigatórios" do

    #Arrange
    #Criar um galpão no banco de dados
    user = User.create!(email: 'bruno@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city:'Rio de Janeiro', area: 60_000, cep: '20000-000', 
                                description:'Galpão do aeroporto do Rio', address: 'Avenida Atlantica, 10')

    #Act
    #abrir a app
    login_as(user)
    visit root_path
    #visitar o galpão
    click_on 'Rio'
    #clicar em editar
    click_on 'Editar'
    fill_in "Nome",	with: ""
    fill_in "Área",	with: ""
    fill_in "CEP",	with: ""
    click_on 'Enviar'

    #Assert
    expect(page).to  have_content "Não foi possível atualizar o galpão."
  end
  
  
end
