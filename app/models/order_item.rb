class OrderItem < ApplicationRecord
  belongs_to :product_model
  belongs_to :order
  validates :quantity, presence: true #posso até dizer que a quantidade tem que ser maior que zero
end
