require 'rails_helper'

describe "Usuário vê seus próprios pedidos" do
  it "e deve estar autenticado" do

  #Arrange

  #Act
  visit root_path
  click_on "Meus Pedidos"

  #Assert
  expect(current_path).to  eq new_user_session_path    
  end

  it "e não vê outros pedidos" do
    first_user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
    second_user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: '12345678')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city:'São Paulo', area: 60_000, cep: '20000-000', 
                                description:'Galpão do aeroporto de SP', address: 'Avenida Atlantica, 10')
    supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', 
                                full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
                                state:'SP', email: 'sac.facebook@facebook.com')
    first_order = Order.create!(user: first_user, warehouse: warehouse, supplier: supplier, 
                                estimated_delivery_date: 1.day.from_now, status: 'pending')
    second_order = Order.create!(user: second_user, warehouse: warehouse, supplier: supplier, 
                                estimated_delivery_date: 1.day.from_now, status: 'delivered')
    third_order = Order.create!(user: first_user, warehouse: warehouse, supplier: supplier, 
                                estimated_delivery_date: 1.week.from_now, status: 'canceled')
    
    login_as(first_user)
    visit root_path
    click_on "Meus Pedidos"

    expect(page).to have_content first_order.code
    expect(page).to have_content 'Pendente' 
    expect(page).to have_content third_order.code
    expect(page).to have_content 'Cancelado'  
    expect(page).not_to have_content second_order.code
    expect(page).not_to have_content 'Entregue'
  end

  it "e visita um pedido" do

    first_user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city:'São Paulo', area: 60_000, cep: '20000-000', 
                                description:'Galpão do aeroporto de SP', address: 'Avenida Atlantica, 10')
    supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', 
                                full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
                                state:'SP', email: 'sac.facebook@facebook.com')
    first_order = Order.create!(user: first_user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    
    
    login_as(first_user)
    visit root_path
    click_on "Meus Pedidos"
    click_on first_order.code

    expect(page).to have_content 'Detalhes do Pedido'
    expect(page).to have_content first_order.code
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
    expect(page).to have_content 'Fornecedor: 12645-412 - Meta'
    formatted_date = I18n.localize(1.day.from_now.to_date)
    expect(page).to have_content "Data Prevista de Entrega: #{formatted_date}" 
  end

  it "e não visita pedidos de outros usuários" do
    first_user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
    second_user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: '12345678')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city:'São Paulo', area: 60_000, cep: '20000-000', 
                                description:'Galpão do aeroporto de SP', address: 'Avenida Atlantica, 10')
    supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', 
                                full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
                                state:'SP', email: 'sac.facebook@facebook.com')
    first_order = Order.create!(user: first_user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    second_order = Order.create!(user: second_user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    
    
    login_as(first_user)
    visit order_path(second_user.id)


    expect(current_path).not_to eq order_path(second_order.id)
    expect(page).to have_content 'Você não possui acesso a este pedido.'  

  
  end

  it 'e vê itens do pedido' do
    supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', 
                                 full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
                                      state:'SP', email: 'sac.facebook@facebook.com')
    product_a = ProductModel.create!(name: 'Produto A', weight: 15, width: 10, height: 20, depth: 30, supplier: supplier, sku: 'PRODUTOA')
    product_b = ProductModel.create!(name: 'Produto B', weight: 15, width: 10, height: 20, depth: 30, supplier: supplier, sku: 'PRODUTOB')
    product_c = ProductModel.create!(name: 'Produto C', weight: 15, width: 10, height: 20, depth: 30, supplier: supplier, sku: 'PRODUTOC')
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
    
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city:'São Paulo', area: 60_000, cep: '20000-000', 
                                description:'Galpão do aeroporto de SP', address: 'Avenida Atlantica, 10')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
                          estimated_delivery_date: 1.week.from_now, status: 'pending')
    OrderItem.create!(product_model: product_a, order: order, quantity: 19)
    OrderItem.create!(product_model: product_b, order: order, quantity: 12)

    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code

    expect(page).to have_content 'Itens do Pedido'
    expect(page).to have_content '19 x Produto A'
    expect(page).to have_content '12 x Produto B'



  end
end
