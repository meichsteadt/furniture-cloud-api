class Customer < ApplicationRecord
  belongs_to :store
  validates :email, uniqueness: true
  has_many :visits, class_name: "Ahoy::Visit"
  has_many :carts, through: :visits, class_name: "Ahoy::Visit"
  has_many :cart_items, through: :carts
  has_many :product_items, through: :cart_items
end
