require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe "#valid?" do
    context "presence" do      
    
      it "false when name is empty" do
        # Arrange
          warehouse = Warehouse.new(name: '', code: 'SDU', city:'Rio de Janeiro', area: 60_000, cep: '20000-000', 
          description:'Galpão do aeroporto do Rio', address: 'Avenida Atlantica, 10')
        # Act
        result = warehouse.valid?
        # Assert
        expect(result).to  eq false
      end

      it "false when code is empty" do
        # Arrange
          warehouse = Warehouse.new(name: 'Rio', code: '', city:'Rio de Janeiro', area: 60_000, cep: '20000-000', 
          description:'Galpão do aeroporto do Rio', address: 'Avenida Atlantica, 10')
        # Act
        result = warehouse.valid?
        # Assert
        expect(result).to  eq false
      end
      
      it "false when city is empty" do
        # Arrange
          warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city:'', area: 60_000, cep: '20000-000', 
          description:'Galpão do aeroporto do Rio', address: 'Avenida Atlantica, 10')
        # Act
        result = warehouse.valid?
        # Assert
        expect(result).to  eq false
      end

      it "false when area is empty" do
        # Arrange
          warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city:'Rio de Janeiro', area: '' , cep: '20000-000', 
          description:'Galpão do aeroporto do Rio', address: 'Avenida Atlantica, 10')
        # Act
        result = warehouse.valid?
        # Assert
        expect(result).to  eq false
      end
      
      it "false when cep is empty" do
        # Arrange
          warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city:'Rio de Janeiro', area: 60_000, cep: '', 
          description:'Galpão do aeroporto do Rio', address: 'Avenida Atlantica, 10')
        # Act
        result = warehouse.valid?
        # Assert
        expect(result).to  eq false
      end

      it "false when description is empty" do
        # Arrange
          warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city:'Rio de Janeiro', area: 60_000, cep: '20000-000', 
          description:'', address: 'Avenida Atlantica, 10')
        # Act
        result = warehouse.valid?
        # Assert
        expect(result).to  eq false
      end
  
      it "false when address is empty" do
        # Arrange
          warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city:'Rio de Janeiro', area: 60_000, cep: '20000-000', 
          description:'Galpão do aeroporto do Rio', address: '')
        # Act
        result = warehouse.valid?
        # Assert
        expect(result).to  eq false
      end
    end

    it "false when code is already in use" do
    # Arrange
    first_warehouse = Warehouse.create(name: 'Rio', code: 'SDU', city:'Rio de Janeiro', area: 60_000, cep: '20000-000', 
                                    description:'Galpão do aeroporto do Rio', address: 'Avenida Atlantica, 10')

    second_warehouse = Warehouse.new(name: 'Niteroi', code: 'SDU', city:'Niteroi', area: 50_000, cep: '30000-000', 
      description:'Galpão do aeroporto de Niteroi', address: 'Avenida dos Reis, 10')


    # Act

    # Assert

    expect(second_warehouse.valid?).to  eq false
      
    end

    
  end

  describe '#full_description' do
    it "exibe nome fantasia e o codigo" do
      w = Warehouse.new(name: 'Galpão Cuiabá', code: 'CBA')

      result = w.full_description()

      expect(result).to  eq('CBA - Galpão Cuiabá')
      
    end
    
  end
  
end
