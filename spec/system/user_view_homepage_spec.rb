require 'rails_helper'

describe 'Usuario visita tela inicial' do
  it 'e vê o nome da app' do
    #Arrange

    #Act
    visit root_path


    #Assert
    expect(page).to have_content('Galpões & Estoque')
    expect(page).to have_link('Galpões & Estoque')
  end

  it 'e vê os galpões cadastrados' do
    #Arrange
    #cadastrar 2 galpões: Rio e Maceio
    User.create!(email: 'bruno@email.com', password: 'password')
    Warehouse.create!(name: 'Rio', code: 'SDU', city:'Rio de Janeiro', area: 60_000, cep: '20000-000', 
                    description:'Galpão do aeroporto do Rio', address: 'Avenida Atlantica, 10')
    Warehouse.create!(name: 'Maceio', code: 'MCZ', city:'Maceio', area: 50_000, cep:'10000-100', 
                    description: 'Galpão do aeroporto de Maceio', address: 'Rua do alemão, 321')

    #Act
    visit root_path
    within('form') do
      fill_in "E-mail",	with: "bruno@email.com"
      fill_in "Senha",	with: "password" 
      click_on "Entrar"
    end

    #Assert
    #garantir que eu vejo na tela os galopões Rio e Maceio
    expect(page).not_to have_content('Não existem galpões cadastrados')
    expect(page).to have_content('Rio')
    expect(page).to have_content('Código: SDU')
    expect(page).to have_content('Cidade: Rio de Janeiro')
    expect(page).to have_content('60000 m2')

    expect(page).to have_content('Maceio')
    expect(page).to have_content('Código: MCZ')
    expect(page).to have_content('Cidade: Maceio')
    expect(page).to have_content('50000 m2')
  end

  it 'e não existem galpões cadastrados' do
    #Arrange
    User.create!(email: 'bruno@email.com', password: 'password')


    #Act
    visit(root_path)
    within('form') do
      fill_in "E-mail",	with: "bruno@email.com"
      fill_in "Senha",	with: "password" 
      click_on "Entrar"
    end

    #Assert
    expect(page).to have_content('Não existem galpões cadastrados')
    
  end
end