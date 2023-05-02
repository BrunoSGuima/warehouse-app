require 'rails_helper'

describe "Usuário adiciona itens ao pedido" do

  it "com sucesso" do
    supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', 
                                 full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
                                      state:'SP', email: 'sac.facebook@facebook.com')
    product_a = ProductModel.create!(name: 'Produto A', weight: 15, width: 10, height: 20, depth: 30, supplier: supplier, sku: 'PRODUTOA')
    product_b = ProductModel.create!(name: 'Produto B', weight: 15, width: 10, height: 20, depth: 30, supplier: supplier, sku: 'PRODUTOB')
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city:'São Paulo', area: 60_000, cep: '20000-000', 
                                description:'Galpão do aeroporto de SP', address: 'Avenida Atlantica, 10')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
                          estimated_delivery_date: 1.week.from_now, status: 'pending')

    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'
    select 'Produto A', from: 'Produto'
    fill_in "Quantidade",	with: "8"
    click_on 'Gravar'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Item adicionado com sucesso'
    expect(page).to have_content '8 x Produto A'  
    
  end

  it "e não vê produtos de outro fornecedor" do
    supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', 
                                 full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
                                      state:'SP', email: 'sac.facebook@facebook.com')
    second_supplier = Supplier.create!(corporate_name: 'Microsoft', brand_name: 'Microsoft', registration_number:'111111-222', 
                                      full_address: 'Rua da Microsoft, 10', city: 'Salvador', 
                                      state:'BA', email: 'sac.microsoft@microsoft.com')
    product_a = ProductModel.create!(name: 'Produto A', weight: 15, width: 10, height: 20, depth: 30, supplier: supplier, sku: 'PRODUTOA')
    product_b = ProductModel.create!(name: 'Produto B', weight: 15, width: 10, height: 20, depth: 30, supplier: second_supplier, sku: 'PRODUTOB')
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city:'São Paulo', area: 60_000, cep: '20000-000', 
                                description:'Galpão do aeroporto de SP', address: 'Avenida Atlantica, 10')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
                          estimated_delivery_date: 1.week.from_now, status: 'pending')

    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'

    expect(page).to have_content 'Produto A'
    expect(page).not_to have_content 'Produto B'
    
  end
  
  
end
