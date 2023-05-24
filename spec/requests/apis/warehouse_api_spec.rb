require 'rails_helper'

describe 'Warehouse API' do
  context 'GET /api/v1/warehouses/1' do
    it 'success' do
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city:'São Paulo', area: 60_000, cep: '20000-000', 
                                    description:'Galpão do aeroporto de SP', address: 'Avenida Atlantica, 10')

      get "/api/v1/warehouses/#{warehouse.id}"

      expect(response.status).to eq 200
      expect(response.content_type).to include "application/json"

      json_response = JSON.parse(response.body)

      expect(json_response["name"]).to eq('Aeroporto SP')
      expect(json_response["code"]).to eq('GRU')
      expect(json_response["city"]).to eq('São Paulo')
      expect(json_response).not_to include ("created_at")
      expect(json_response).not_to include ("updated _at")
    end

    it "fail if warehouse not found" do

      get "/api/v1/warehouses/999999"
        
      expect(response.status).to eq 404  
    end   
  end
  
  context "GET /api/v1/warehouses" do #endpoint
    it 'list all warehouses and ordered by name' do
      Warehouse.create!(name: 'Rio', code: 'SDU', city:'Rio de Janeiro', area: 60_000, cep: '20000-000', 
        description:'Galpão do aeroporto do Rio', address: 'Avenida Atlantica, 10')
      Warehouse.create!(name: 'Maceio', code: 'MCZ', city:'Maceio', area: 50_000, cep:'10000-100', 
        description: 'Galpão do aeroporto de Maceio', address: 'Rua do alemão, 321')

      get '/api/v1/warehouses'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response[0]["name"]).to  eq "Maceio"
      expect(json_response[1]["name"]).to  eq "Rio"
    end

    it "return empty if there is no warehouse" do

      get '/api/v1/warehouses'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq [] 
      
    end

    it "and raise internal error" do
      allow(Warehouse).to receive(:all).and_raise(ActiveRecord::QueryCanceled)

      get '/api/v1/warehouses'

      expect(response).to have_http_status(500) 
      
    end
    
    
  end

  context "POST /api/v1/warehouses" do
    it "sucess" do

      warehouse_params = {warehouse: {name: 'Maceio', code: 'MCZ', city:'Maceio', area: 50_000, cep:'10000-100', 
                                     description: 'Galpão do aeroporto de Maceio', address: 'Rua do alemão, 321'}
                        }

      post '/api/v1/warehouses', params: warehouse_params


      expect(response).to have_http_status(:created)
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["name"]).to eq('Maceio')
      expect(json_response["code"]).to eq('MCZ')
      expect(json_response["city"]).to eq('Maceio')
      expect(json_response["area"]).to eq(50_000)
      expect(json_response["cep"]).to eq('10000-100')
      expect(json_response["address"]).to eq('Rua do alemão, 321')
      expect(json_response["description"]).to eq('Galpão do aeroporto de Maceio')
      
    end

    it "fail if parameters are not completed" do
      
      warehouse_params = {warehouse: {name: "Aeroporto Curitiba", code: "CWB"} }

      post '/api/v1/warehouses', params: warehouse_params
      expect(response).to have_http_status(412)
      expect(response.body).not_to include "Nome não pode ficar em branco"
      expect(response.body).not_to include "Código não pode ficar em branco"
      expect(response.body).to include "Endereço não pode ficar em branco"
      expect(response.body).to include "Cidade não pode ficar em branco"
      expect(response.body).to include "CEP não pode ficar em branco"
      expect(response.body).to include "Área não pode ficar em branco"
    end

    it "fails if there is an internal error" do

      allow(Warehouse).to receive(:new).and_raise(ActiveRecord::ActiveRecordError)

      warehouse_params = {warehouse: {name: 'Maceio', code: 'MCZ', city:'Maceio', area: 50_000, cep:'10000-100', 
                           description: 'Galpão do aeroporto de Maceio', address: 'Rua do alemão, 321'}
                          }

      post '/api/v1/warehouses', params: warehouse_params

      expect(response).to have_http_status(500)  

        
      
    end
    
    
    
    
  end
  
end