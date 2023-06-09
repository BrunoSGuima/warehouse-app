require 'rails_helper'

describe 'Usuário cadastra um pedido' do
  it "e deve estar autenticado" do

    visit root_path
    click_on 'Registrar Pedido'

    expect(page).to  have_content 'Para continuar, faça login ou registre-se'
    expect(current_path).to  eq new_user_session_path
    
  end
  

  it 'com sucesso' do  
  #Arrange
  user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
  Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city:'Maceio', area: 50_000, cep:'10000-100', 
                    description: 'Galpão do aeroporto de Maceio', address: 'Rua do alemão, 321')
  warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'SDU', city:'São Paulo', area: 60_000, cep: '20000-000', 
                                description:'Galpão do aeroporto de SP', address: 'Avenida Atlantica, 10')
  Supplier.create!(corporate_name: 'Microsoft', brand_name: 'Microsoft', registration_number:'111111-222', 
                      full_address: 'Rua da Microsoft, 10', city: 'Salvador', state:'BA', email: 'sac.microsoft@microsoft.com')
  supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', 
                               full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
                                state:'SP', email: 'sac.facebook@facebook.com')

  

  allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
  #Act
  login_as(user)
  visit root_path
  click_on 'Registrar Pedido'
  select 'SDU - Aeroporto SP', from: 'Galpão Destino'
  select '12645-412 - Meta', from: "Fornecedor"
  fill_in 'Data Prevista de Entrega', with: '20/12/2023'
  click_on 'Gravar'
  
  #Assert
  expect(page).to  have_content 'Pedido registrado com sucesso.'
  expect(page).to  have_content 'Pedido ABC12345'
  expect(page).to  have_content 'Galpão Destino: SDU - Aeroporto SP'
  expect(page).to  have_content 'Fornecedor: 12645-412 - Meta'
  expect(page).to  have_content 'Usuário Responsável: Sergio - sergio@email.com'
  expect(page).to  have_content 'Data Prevista de Entrega: 20/12/2023'
  expect(page).to  have_content 'Status do Pedido: Pendente'
  expect(page).not_to have_content 'Galpão Maceio'
  expect(page).not_to have_content 'Microsoft'
  end

  it "e o pedido não é registrado" do
    # Arrange
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'SDU', city:'São Paulo', area: 60_000, cep: '20000-000', 
      description:'Galpão do aeroporto de SP', address: 'Avenida Atlantica, 10')
    supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', 
                    full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
                      state:'SP', email: 'sac.facebook@facebook.com')
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
    #Act
    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select 'SDU - Aeroporto SP', from: 'Galpão Destino'
    select '12645-412 - Meta', from: "Fornecedor"
    fill_in 'Data Prevista de Entrega', with: '20/12/2022'
    click_on 'Gravar'

    expect(page).to have_content 'Pedido não registrado.'
    expect(page).to  have_content 'Data Prevista de Entrega deve ser futura'

  end
  
end