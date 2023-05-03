require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe "gera um número de série" do
    it "ao criar um StockProduct" do
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'SDU', city:'São Paulo', area: 60_000, cep: '20000-000', 
                                   description:'Galpão do aeroporto de SP', address: 'Avenida Atlantica, 10')
      supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', 
                                full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
                                   state:'SP', email: 'sac.facebook@facebook.com')
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, status: :delivered, estimated_delivery_date: 1.week.from_now)
      product_a = ProductModel.create!(name: 'Cadeira Gamer', weight: 5, width: 70, height: 100, depth: 75, supplier: supplier, sku: 'CAD-GAMER-1324')
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product_a)
      
      expect(stock_product.serial_number.length).to eq 20
    end

    it "e não é modificado" do
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'SDU', city:'São Paulo', area: 60_000, cep: '20000-000', 
                                   description:'Galpão do aeroporto de SP', address: 'Avenida Atlantica, 10')
      second_warehouse = Warehouse.create!(name: 'teste', code: 'teste', city:'teste', area: 60_000, cep: '20000-000', 
                                    description:'Galpão do aeroporto de SP', address: 'Avenida Atlantica, 10')
      supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', 
                                full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
                                   state:'SP', email: 'sac.facebook@facebook.com')
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, status: :delivered, estimated_delivery_date: 1.week.from_now)
      product_a = ProductModel.create!(name: 'Cadeira Gamer', weight: 5, width: 70, height: 100, depth: 75, supplier: supplier, sku: 'CAD-GAMER-1324')
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product_a)
      original_serial_number = stock_product.serial_number

      stock_product.update!(warehouse: second_warehouse)

      expect(stock_product.serial_number).to eq(original_serial_number)
      
    end 
    
    
  end

  describe "#available?" do

    it "true se não tiver destino" do
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'SDU', city:'São Paulo', area: 60_000, cep: '20000-000', 
                                   description:'Galpão do aeroporto de SP', address: 'Avenida Atlantica, 10')
      supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', 
                                full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
                                   state:'SP', email: 'sac.facebook@facebook.com')
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, status: :delivered, estimated_delivery_date: 1.week.from_now)
      product_a = ProductModel.create!(name: 'Cadeira Gamer', weight: 5, width: 70, height: 100, depth: 75, supplier: supplier, sku: 'CAD-GAMER-1324')
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product_a)

      expect(stock_product.available?).to eq true
      
    end

    it "false se tiver destino" do
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'SDU', city:'São Paulo', area: 60_000, cep: '20000-000', 
                                   description:'Galpão do aeroporto de SP', address: 'Avenida Atlantica, 10')
      supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', 
                                full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
                                   state:'SP', email: 'sac.facebook@facebook.com')
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, status: :delivered, estimated_delivery_date: 1.week.from_now)
      product_a = ProductModel.create!(name: 'Cadeira Gamer', weight: 5, width: 70, height: 100, depth: 75, supplier: supplier, sku: 'CAD-GAMER-1324')
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product_a)
      stock_product.create_stock_product_destination!(recipient: "Joao", address: "Rua do Joao")

      expect(stock_product.available?).to eq false
      
    end
    
    
    
  end
  
  

end
