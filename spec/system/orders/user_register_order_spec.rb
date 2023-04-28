require 'rails_helper'

describe 'Usuário cadastra um pedido' do

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
  
  #Act
  login_as(user)
  visit root_path
  click_on 'Registrar Pedido'
  select warehouse.name, from: 'Galpão Destino'
  select supplier.corporate_name, from: "Fornecedor"
  fill_in 'Data Prevista de Entrega', with: '20/12/2022'
  click_on 'Gravar'
  
  #Assert
  expect(page).to  have_content 'Pedido registrado com sucesso.'
  expect(page).to  have_content 'Galpão Destino: Aeroporto SP'
  expect(page).to  have_content 'Fornecedor: Meta'
  expect(page).to  have_content 'Usuário Responsável: Sergio | sergio@email.com |'
  expect(page).to  have_content 'Data Prevista de Entrega: 20/12/2022'
  expect(page).not_to have_content 'Galpão Maceio'
  expect(page).not_to have_content 'Microsoft'
  end
  
end