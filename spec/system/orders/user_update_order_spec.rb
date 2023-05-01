require 'rails_helper'

describe "Usuário informa novo status de pedido" do
  it "e pedido foi entregue" do
    first_user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city:'São Paulo', area: 60_000, cep: '20000-000', 
                                description:'Galpão do aeroporto de SP', address: 'Avenida Atlantica, 10')
    supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', 
                                full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
                                state:'SP', email: 'sac.facebook@facebook.com')
    first_order = Order.create!(user: first_user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: 'pending')
    
    login_as(first_user)
    visit root_path
    click_on "Meus Pedidos"
    click_on first_order.code
    click_on 'Marcar como ENTREGUE'

    expect(current_path).to eq order_path(first_order.id)
    expect(page).to have_content('Status do Pedido: Entregue')
    expect(page).not_to have_button 'Marcar como ENTREGUE'
    expect(page).not_to have_button 'Marcar como CANCELADO'

  
  end

  it "e pedido foi cancelado" do
    first_user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city:'São Paulo', area: 60_000, cep: '20000-000', 
                                description:'Galpão do aeroporto de SP', address: 'Avenida Atlantica, 10')
    supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', 
                                full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
                                state:'SP', email: 'sac.facebook@facebook.com')
    first_order = Order.create!(user: first_user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: 'pending')
    
    login_as(first_user)
    visit root_path
    click_on "Meus Pedidos"
    click_on first_order.code
    click_on 'Marcar como CANCELADO'

    expect(current_path).to eq order_path(first_order.id)
    expect(page).to have_content 'Status do Pedido: Cancelado'  
    
  end
   
end
