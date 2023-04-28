require 'rails_helper'

describe "Usuário vê detalhes do fornecedor" do
  it "a partir da tela inicial" do
    user = User.create!(email: 'bruno@email.com', password: 'password')
    Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
                    state:'SP', email: 'sac.facebook@facebook.com')

    login_as(user)
    visit root_path
    click_on 'Fornecedores'
    click_on 'Facebook'
    

    expect(page).to have_content 'Facebook'
    expect(page).to have_content '12645-412'
    expect(page).to have_content 'Rua do Facebook, 09'
    expect(page).to have_content 'São Paulo'
    expect(page).to have_content 'SP'
    expect(page).to have_content 'sac.facebook@facebook.com'
  end

  it "e volta para a tela inicial" do
    user = User.create!(email: 'bruno@email.com', password: 'password')
    Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
      state:'SP', email: 'sac.facebook@facebook.com')

    login_as(user)
    visit root_path
    click_on 'Fornecedores'
    click_on 'Facebook'
    click_on 'Voltar'
    

    expect(current_path).to eq root_path
  end

end