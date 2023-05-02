require 'rails_helper'

describe "Usuário vê o estoque" do
  it "na tela do galpão" do
    # Arrenge
    user = User.create!(email: 'bruno@email.com', password: 'password')
    w = Warehouse.new(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
                     address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                     description: 'Galpão destinado para cargas internacionais')
    sup1 = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number:'12645-412', 
                            full_address: 'Rua da Samsung, 09', city: 'São Paulo', 
                            state:'SP', email: 'sac@samsung.com')
    produto_tv = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, 
                          sku: 'TV32-SAMSU-XPTO90' , supplier: sup1)
    produto_soundbar = ProductModel.create!(name: 'Soundbar 7.1 Surround', weight: 3000, width: 80, height: 15, depth: 15, 
                          sku: 'SO71-SAMSU-NOIZ77' , supplier: sup1)
    produto_notebook = ProductModel.create!(name: 'Notebook i5 16GB RAM', weight: 2000, width: 40, height: 10, depth: 20, 
                            sku: 'NOTEI5-SAMSU-TLI99' , supplier: sup1)
    order = Order.create!(user: user, warehouse: w, supplier: sup1,
                              estimated_delivery_date: 1.week.from_now, status: 'pending')

    3.times{ StockProduct.create!(order: order, warehouse: w, product_model: produto_tv)}
    2.times{ StockProduct.create!(order: order, warehouse: w, product_model: produto_notebook)}

    # Act
    login_as(user)
    visit root_path
    click_on 'Aeroporto SP'

    #Assert
    expect(page).to have_content 'Itens em Estoque'
    expect(page).to have_content '3 x TV32-SAMSU-XPTO90'
    expect(page).to have_content '2 x NOTEI5-SAMSU-TLI99'
    expect(page).not_to have_content 'SO71-SAMSU-NOIZ77'

    
    
  end
  
  
end
