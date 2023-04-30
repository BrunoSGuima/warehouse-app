require 'rails_helper'

describe "Usuário busca por um pedido" do
  it "a partir do menu" do
    # Arrange
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')

    # Act
    login_as(user)
    visit root_path

    # Assert
    within('header nav') do
      expect(page).to have_field('Buscar Pedido')
      expect(page).to have_button('Buscar')
    end  
  end

  it "e deve estar autenticado" do
    # Arrange

    # Act
    visit root_path

    # Assert
    within('header nav') do
      expect(page).not_to have_field('Buscar Pedido')
      expect(page).not_to have_button('Buscar')
    end  
  end

  it "e encontra um pedido" do
    # Arrange
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city:'São Paulo', area: 60_000, cep: '20000-000', 
                                description:'Galpão do aeroporto de SP', address: 'Avenida Atlantica, 10')
    supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', 
                                full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
                                state:'SP', email: 'sac.facebook@facebook.com')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    # Act
    login_as(user)
    visit root_path
    fill_in "Buscar Pedido",	with: order.code
    click_on 'Buscar'

    # Assert
    expect(page).to have_content "Resultados da Busca por: #{order.code}"
    expect(page).to have_content '1 pedido encontrado'
    expect(page).to have_content "Código: #{order.code}"
    expect(page).to have_content "Galpão Destino: GRU - Aeroporto SP"
    expect(page).to have_content "Fornecedor: 12645-412 - Meta" 
  end
  
  
end
