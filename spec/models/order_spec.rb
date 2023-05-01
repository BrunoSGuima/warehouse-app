require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it "deve ter um código" do
      # Arrange
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'SDU', city:'São Paulo', area: 60_000, cep: '20000-000', 
                                  description:'Galpão do aeroporto de SP', address: 'Avenida Atlantica, 10')
      supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', 
                                full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
                                   state:'SP', email: 'sac.facebook@facebook.com')
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2023-10-01')

      # Act
      result = order.valid?

      # Assert
      expect(result).to  be true
    end
    
    it "data estimada de entrega deve ser obrigatória" do
    # Arrange
    order = Order.new(estimated_delivery_date: '')

    # Act
    order.valid?
    result = order.errors.include?(:estimated_delivery_date)


    # Assert
    expect(result).to  be true
      
    end

    it "data estimada de entrega não deve ser passada" do
      # Arrange
      order = Order.new(estimated_delivery_date: 1.day.ago)

      # Act
      order.valid?
      result = order.errors.include?(:estimated_delivery_date)

      # Assert
      expect(result).to be true 
      expect(order.errors[:estimated_delivery_date]).to include(" deve ser futura.")
      
    end

    it "data estimada de entrega não deve ser igual a hoje" do
      # Arrange
      order = Order.new(estimated_delivery_date: Date.today)

      # Act
      order.valid?
      result = order.errors.include?(:estimated_delivery_date)

      # Assert
      expect(result).to be true 
      expect(order.errors[:estimated_delivery_date]).to include(" deve ser futura.")
      
    end

    #MANEIRA MAIS CORRETA DE SE ESCREVER:
    it "data estimada de entrega deve ser igual ou maior que amanhã" do
      # Arrange
      order = Order.new(estimated_delivery_date: 1.day.from_now)

      # Act
      order.valid?

      # Assert
      expect(order.errors.include?(:estimated_delivery_date)).to be false
      
    end
    
    
  end
  describe "gera um código aleatório" do
    it "ao criar um novo pedido" do
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'SDU', city:'São Paulo', area: 60_000, cep: '20000-000', 
                                description:'Galpão do aeroporto de SP', address: 'Avenida Atlantica, 10')
    supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', 
                                full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
                                   state:'SP', email: 'sac.facebook@facebook.com')
    order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2023-10-01')

    order.save!
    result = order.code

    expect(result).not_to be_empty
    expect(result.length).to eq 10
      
    end

    it "e o código é único" do
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'SDU', city:'São Paulo', area: 60_000, cep: '20000-000', 
        description:'Galpão do aeroporto de SP', address: 'Avenida Atlantica, 10')
      supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', 
                                full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
                                   state:'SP', email: 'sac.facebook@facebook.com')

      first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2023-10-01')
      second_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2023-11-15')

     second_order.save!
     


     expect(second_order.code).not_to eq first_order.code  
    end
    
    
  end
  

end
