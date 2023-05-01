require 'rails_helper'

describe "Usúario edita um pedido" do
  it "e não é o dono" do
    first_user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
    second_user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: '12345678')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city:'São Paulo', area: 60_000, cep: '20000-000', 
                                description:'Galpão do aeroporto de SP', address: 'Avenida Atlantica, 10')
    supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', 
                                full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
                                state:'SP', email: 'sac.facebook@facebook.com')
    first_order = Order.create!(user: first_user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    login_as(second_user)
    patch(order_path(first_order.id), params: {order: {supplier_id: 3}}) # O params em diante foi para demonstrar uma possibilidade.

    expect(response).to redirect_to(root_path)
    
  end
  
  
end
