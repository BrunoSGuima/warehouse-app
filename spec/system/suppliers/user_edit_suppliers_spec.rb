require 'rails_helper'

describe "Usuário edita um fornecedor" do

  it "a partir da página de detalhes" do

    #Arrange
    #Criar um galpão no banmdo de dados
    supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
      state:'SP', email: 'sac.facebook@facebook.com')
    #Act
    #abrir a app
    visit root_path
    click_on 'Fornecedores'
    click_on "Facebook"
    #clicar em editar
    click_on 'Editar'
    #trocar algo no formulario

    #submeter

    #Assert
    # garantir que o formulário aparece
    expect(page).to have_content('Editar Fornecedores')
    expect(page).to have_field('Nome Fantasia')
    expect(page).to have_field('Razão Social')
    expect(page).to have_field('CNPJ')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Estado')
    expect(page).to have_field('E-mail')
    end

    it "com sucesso" do

      #Arrange
      #Criar um galpão no banmdo de dados
      supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
                                  state:'SP', email: 'sac.facebook@facebook.com')
  
      #Act
      visit root_path
      click_on 'Fornecedores'
      click_on "Facebook"
      click_on 'Editar'
      fill_in "Nome Fantasia",	with: "Twitter"
      fill_in "Cidade",	with: "Orlando"
      fill_in "Estado",	with: "Florida"
      click_on 'Enviar'
      
  
      #Assert
      expect(page).to  have_content "Fornecedor atualizado com sucesso!"
      expect(page).to  have_content "Twitter"
      expect(page).to  have_content "Orlando"
      expect(page).to  have_content "Florida"
    end

    it "mantém os campos obrigatórios" do

      #Arrange

      supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
        state:'SP', email: 'sac.facebook@facebook.com')

      #Act
      #abrir a app
      visit root_path

      visit root_path
      click_on 'Fornecedores'
      click_on "Facebook"
      click_on 'Editar'
      fill_in "Nome Fantasia",	with: ""
      fill_in "Cidade",	with: ""
      fill_in "Estado",	with: ""
      click_on 'Enviar'
  
      #Assert
      expect(page).to  have_content "Não foi possível atualizar o fornecedor."
    end
  end