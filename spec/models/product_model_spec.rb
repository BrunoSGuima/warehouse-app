require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe "#valid?" do
    it 'name is mandatory' do
      # Arrenge
      sup1 = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number:'12645-412', 
                              full_address: 'Rua da Samsung, 09', city: 'São Paulo', state:'SP', email: 'sac@samsung.com')
      pm = ProductModel.new(name: '', weight: 8000, width: 70, height: 45, depth: 10, 
                            sku: 'TV32-SAMSU-XPTO90' , supplier: sup1)

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false  
    end
    
  end
  

end
