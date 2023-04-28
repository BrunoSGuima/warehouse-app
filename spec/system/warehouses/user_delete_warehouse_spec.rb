require 'rails_helper'

describe "Usúario remove um galpão" do
  it "com sucesso" do

  	#Arrange
  	#Criar um galpão
  	user = User.create!(email: 'bruno@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city:'Rio de Janeiro', area: 60_000, cep: '20000-000', 
                                    description:'Galpão do aeroporto do Rio', address: 'Avenida Atlantica, 10')

    #Act
    #visitar a tela inicial
    login_as(user)
    visit root_path
    #abrir o galpão
    click_on 'Rio'
    #clicar em remover
    click_on 'Remover'

    #Assert
    expect(current_path).to eq root_path
      #o galpão não aparece mais na lista
    expect(page).to  have_content "Galpão removido com sucesso!"
    expect(page).not_to  have_content "Rio"
    expect(page).not_to  have_content "SDU"
    expect(page).not_to  have_content "Rio de Janeiro"
    expect(page).not_to  have_content "60000"
  end

  it "com sucesso" do

  	#Arrange
    #Criar um galpão
    user = User.create!(email: 'bruno@email.com', password: 'password')
    first_warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city:'Rio de Janeiro', area: 60_000, cep: '20000-000', 
                                    description:'Galpão do aeroporto do Rio', address: 'Avenida Atlantica, 10')
    second_warehouse = Warehouse.create!(name: 'Belo Horizonte', code: 'BHZ', city:'Belo Horizonte', area: 20000, cep: '46000-000', 
                                      description:'Galpão do aeroporto do Belo Horizonte', address: 'Avenida Tiradentes, 20')

    #Act
    login_as(user)
      #visitar a tela inicial
    visit root_path
      #abrir o galpão
    click_on 'Rio'
      #clicar em remover
    click_on 'Remover'

    #Assert
    expect(current_path).to eq root_path
      #o galpão não aparece mais na lista
    expect(page).to  have_content "Galpão removido com sucesso!"
    expect(page).to  have_content "Belo Horizonte"
    expect(page).to  have_content "BHZ"
    expect(page).to  have_content "Belo Horizonte"
    expect(page).to  have_content "20000"
    expect(page).not_to  have_content "Rio"
  end
end
