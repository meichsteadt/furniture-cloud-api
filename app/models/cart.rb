class Cart < ApplicationRecord
  belongs_to :visit, class_name: "Ahoy::Visit"
  has_one :customer, through: :visit
  has_many :cart_items
  has_many :products, through: :cart_items
end
