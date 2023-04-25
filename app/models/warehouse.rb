class Warehouse < ApplicationRecord
  validates :name, :code, :city, :area, :address, :description, :cep, presence: true
  validates :code, uniqueness: true
end
