require 'rails_helper'

describe "Usuário edita pedido" do
  it "e deve estar autenticado" do

    first_user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city:'São Paulo', area: 60_000, cep: '20000-000', 
                                description:'Galpão do aeroporto de SP', address: 'Avenida Atlantica, 10')
    supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', 
                                full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
                                state:'SP', email: 'sac.facebook@facebook.com')
    first_order = Order.create!(user: first_user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    
    
    visit edit_order_path(first_order.id)

    expect(current_path).to eq new_user_session_path 
  end

  it "com sucesso" do

    first_user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city:'São Paulo', area: 60_000, cep: '20000-000', 
                                description:'Galpão do aeroporto de SP', address: 'Avenida Atlantica, 10')
    first_supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', 
                                full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
                                state:'SP', email: 'sac.facebook@facebook.com')
    second_supplier = Supplier.create!(corporate_name: 'Microsoft', brand_name: 'Microsoft', registration_number:'111111-222', 
                                  full_address: 'Rua da Microsoft, 10', city: 'Salvador', state:'BA', email: 'sac.microsoft@microsoft.com')
    first_order = Order.create!(user: first_user, warehouse: warehouse, supplier: first_supplier, estimated_delivery_date: 1.day.from_now)
    
    
    login_as(first_user)
    visit root_path
    click_on "Meus Pedidos"
    click_on first_order.code
    click_on 'Editar'
    fill_in 'Data Prevista de Entrega', with: '12/12/2023'
    select 'Microsoft', from: 'Fornecedor'
    click_on 'Gravar'

    expect(page).to have_content 'Pedido atualizado com sucesso.'
    expect(page).to have_content 'Data Prevista de Entrega: 12/12/2023'
    expect(page).to have_content 'Fornecedor: 111111-222 - Microsoft'
  end

  it "caso seja o responsável" do

    first_user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
    second_user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: '12345678')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city:'São Paulo', area: 60_000, cep: '20000-000', 
                                description:'Galpão do aeroporto de SP', address: 'Avenida Atlantica, 10')
    supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', 
                                full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
                                state:'SP', email: 'sac.facebook@facebook.com')
    first_order = Order.create!(user: first_user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    
    
    login_as(second_user)
    visit edit_order_path(first_order.id)

    expect(current_path).to eq root_path 
  end
  
end
