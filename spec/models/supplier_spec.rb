require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe "#valid?" do
    context "presence" do      
    
      it "false when corporate_name is empty" do
        # Arrange
        s = Supplier.new(corporate_name: '', brand_name: 'Facebook', 
          registration_number:'12645-412', full_address: 'Rua do Facebook, 09', 
          city: 'São Paulo', state:'SP', email: 'sac.facebook@facebook.com')  
        # Act
        result = s.valid?
        # Assert
        expect(result).to  eq false
      end

      it "false when brand_name is empty" do
        # Arrange
        s = Supplier.new(corporate_name: 'Meta', brand_name: '', 
          registration_number:'12645-412', full_address: 'Rua do Facebook, 09', 
          city: 'São Paulo', state:'SP', email: 'sac.facebook@facebook.com')  
        # Act
        result = s.valid?
        # Assert
        expect(result).to  eq false
      end

      it "false when registration_number is empty" do
        # Arrange
        s = Supplier.new(corporate_name: 'Meta', brand_name: 'Facebook', 
          registration_number:'', full_address: 'Rua do Facebook, 09', 
          city: 'São Paulo', state:'SP', email: 'sac.facebook@facebook.com')  
        # Act
        result = s.valid?
        # Assert
        expect(result).to  eq false
      end

      it "false when full_address is empty" do
        # Arrange
        s = Supplier.new(corporate_name: 'Meta', brand_name: 'Facebook', 
          registration_number:'12645-412', full_address: '', 
          city: 'São Paulo', state:'SP', email: 'sac.facebook@facebook.com')  
        # Act
        result = s.valid?
        # Assert
        expect(result).to  eq false
      end

      it "false when city is empty" do
        # Arrange
        s = Supplier.new(corporate_name: 'Meta', brand_name: 'Facebook', 
          registration_number:'12645-412', full_address: 'Rua do Facebook, 09', 
          city: '', state:'SP', email: 'sac.facebook@facebook.com')  
        # Act
        result = s.valid?
        # Assert
        expect(result).to  eq false
      end

      it "false when state is empty" do
        # Arrange
        s = Supplier.new(corporate_name: 'Meta', brand_name: 'Facebook', 
          registration_number:'12645-412', full_address: 'Rua do Facebook, 09', 
          city: 'São Paulo', state:'', email: 'sac.facebook@facebook.com')  
        # Act
        result = s.valid?
        # Assert
        expect(result).to  eq false
      end

      it "false when email is empty" do
        # Arrange
        s = Supplier.new(corporate_name: 'Meta', brand_name: 'Facebook', 
          registration_number:'12645-412', full_address: 'Rua do Facebook, 09', 
          city: 'São Paulo', state:'SP', email: '')  
        # Act
        result = s.valid?
        # Assert
        expect(result).to  eq false
      end
      

      it "false when corporate_name is already in use" do
        # Arrange
        first_supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', 
                                          registration_number:'12645-412', full_address: 'Rua do Facebook, 09', 
                                          city: 'São Paulo', state:'SP', email: 'sac.facebook@facebook.com')  
        second_supplier = Supplier.new(corporate_name: 'Meta', brand_name: 'teste1', 
          registration_number:'12645-412', full_address: 'teste1', 
          city: 'teste1', state:'tt', email: 'teste@teste.com')
    
    
        # Act
    
        # Assert
    
        expect(second_supplier.valid?).to  eq false
          
      end
    end
  end
end
