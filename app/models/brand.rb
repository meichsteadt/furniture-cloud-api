class Brand < ApplicationRecord
  has_many :products
  has_many :mattresses
end
