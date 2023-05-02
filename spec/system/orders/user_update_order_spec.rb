require 'rails_helper'

describe "Usuário informa novo status de pedido" do
  it "e pedido foi entregue" do
    first_user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city:'São Paulo', area: 60_000, cep: '20000-000', 
                                description:'Galpão do aeroporto de SP', address: 'Avenida Atlantica, 10')
    supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', 
                                full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
                                state:'SP', email: 'sac.facebook@facebook.com')
    product_a = ProductModel.create!(name: 'Cadeira Gamer', weight: 5, width: 70, height: 100, depth: 75, supplier: supplier, sku: 'CAD-GAMER-1324')
    order = Order.create!(user: first_user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now, status: 'pending')
    OrderItem.create!(order: order, product_model: product_a, quantity: 5)

    login_as(first_user)
    visit root_path
    click_on "Meus Pedidos"
    click_on order.code
    click_on 'Marcar como ENTREGUE'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content('Status do Pedido: Entregue')
    expect(page).not_to have_button 'Marcar como ENTREGUE'
    expect(page).not_to have_button 'Marcar como CANCELADO'
    expect(StockProduct.count).to eq 5
    estoque = StockProduct.where(product_model: product_a, warehouse: warehouse).count
    expect(estoque).to eq 5
  
  end

  it "e pedido foi cancelado" do
    first_user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city:'São Paulo', area: 60_000, cep: '20000-000', 
                                description:'Galpão do aeroporto de SP', address: 'Avenida Atlantica, 10')
    supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', 
                                full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
                                state:'SP', email: 'sac.facebook@facebook.com')
    product_a = ProductModel.create!(name: 'Cadeira Gamer', weight: 5, width: 70, height: 100, depth: 75, supplier: supplier, sku: 'CAD-GAMER-1324')
    order = Order.create!(user: first_user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: 'pending')
    OrderItem.create!(order: order, product_model: product_a, quantity: 5)
    
    login_as(first_user)
    visit root_path
    click_on "Meus Pedidos"
    click_on order.code
    click_on 'Marcar como CANCELADO'
    expect(StockProduct.count).to eq 0

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Status do Pedido: Cancelado'  
    
  end
   
end
