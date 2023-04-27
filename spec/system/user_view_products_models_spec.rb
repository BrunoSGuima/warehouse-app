require 'rails_helper'

describe "Usuário vê modelos de produtos" do

  it "se estiver autenticado" do

    #Arrenge
    
    #Act
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end
    #Assert
    expect(current_path).to  eq new_user_session_path
    
  end
  

  it "a partir do menu" do

    #Arrenge
    user = User.create!(email: 'bruno@email.com', password: 'password')
    #Act
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end
    
    #Assert
    expect(current_path).to eq product_models_path  
  end

  it "com sucesso" do

    #Arrenge
    user = User.create!(email: 'bruno@email.com', password: 'password')
    sup1 = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number:'12645-412', 
                                full_address: 'Rua da Samsung, 09', city: 'São Paulo', 
                                state:'SP', email: 'sac@samsung.com')
    ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, 
                        sku: 'TV32-SAMSU-XPTO90' , supplier: sup1)
    ProductModel.create!(name: 'Soundbar 7.1 Surround', weight: 3000, width: 80, height: 15, depth: 15, 
                          sku: 'SO71-SAMSU-NOIZ77' , supplier: sup1)

    #Act
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end
    
    #Assert
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'TV32-SAMSU-XPTO90'
    expect(page).to have_content 'Samsung'
    expect(page).to have_content 'Soundbar 7.1 Surround'
    expect(page).to have_content 'SO71-SAMSU-NOIZ77'
    expect(page).to have_content 'Samsung'

  end

  it "e não existem produtos cadastrados" do
    user = User.create!(email: 'bruno@email.com', password: 'password')
    
    login_as(user)
    visit root_path
    click_on 'Modelos de Produtos'

    expect(page).to have_content 'Nenhum modelo de produto cadastrado.'
    
  end
  
  
  
end
