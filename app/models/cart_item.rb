class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  has_one :customer, through: :cart

  validates :product_id, uniqueness: {scope: :cart_id}
end
