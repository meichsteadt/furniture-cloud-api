class Product < ApplicationRecord
  has_many :product_items
  has_many :set_prices
  has_many :related_products
  belongs_to :brand
  has_and_belongs_to_many :users
  has_and_belongs_to_many :promotions
  has_and_belongs_to_many :categories
  paginates_per 48

  def get_price(user)
    self.set_prices.find_by(user_id: user.id).price
    rescue
      nil
  end
end
