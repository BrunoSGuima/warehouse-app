require 'rails_helper'

describe "Usuário registra um modelo de produto" do
  it "com sucesso" do
    #Arrenge
    Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number:'12645-412', 
                          full_address: 'Rua da Samsung, 09', city: 'São Paulo', 
                           state:'SP', email: 'sac@samsung.com')
    #Act
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo'
    fill_in 'Nome', with: 'TV 32 polegadas'
    fill_in 'Peso', with: 8000
    fill_in 'Largura', with: 70
    fill_in 'Altura', with: 45
    fill_in 'Profundidade', with: 10
    fill_in 'SKU', with: 'TV32-SAMSU-XPTO90'
    select 'Samsung', from: 'Fornecedor'
    click_on 'Enviar'
    
    #Assert
    expect(page).to have_content 'Modelo de produto cadastrado com sucesso.'
    expect(page).to have_content 'TV 32 polegadas'
    expect(page).to have_content 'TV32-SAMSU-XPTO90'
    expect(page).to have_content 'Fornecedor: Samsung'
    expect(page).to have_content 'Dimensão: 70cm x 45cm x 10cm'
    expect(page).to have_content 'Peso: 8000g'
    
  end
  
  
end
