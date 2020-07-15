class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  has_one :customer, through: :cart
end
