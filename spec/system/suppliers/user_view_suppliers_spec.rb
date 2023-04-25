require 'rails_helper'

describe "Usuário vê fornecedores" do
  it "a partir do menu" do
    
    visit root_path
    within ('nav') do
      click_on 'Fornecedores'
    end
    expect(current_path).to eq suppliers_path  
    
  end

  it "cadastrados" do
    #Arrange
    Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
      state:'SP', email: 'sac.facebook@facebook.com')
    Supplier.create!(corporate_name: 'Microsoft', brand_name: 'Microsoft', registration_number:'111111-222', full_address: 'Rua da Microsoft, 10', city: 'Salvador', 
      state:'BA', email: 'sac.microsoft@microsoft.com')
    
    visit root_path  
    click_on 'Fornecedores'

    expect(page).to have_content('Fornecedores')
    expect(page).to have_content('Facebook')
    expect(page).to have_content('São Paulo - SP')
    expect(page).to have_content('Salvador - BA')
    expect(page).to have_content('Microsoft')
    
  end

  it "e não existem fornecedores cadastrados" do
    #Arrange

    
    visit root_path  
    click_on 'Fornecedores'

    expect(page).to have_content 'Não existem fornecedores cadastrados.'
  end

   
end
