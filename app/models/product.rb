class Product < ApplicationRecord
  has_many :product_items
  has_many :set_prices
  has_many :related_products
  belongs_to :brand
  has_and_belongs_to_many :users
  has_and_belongs_to_many :promotions
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :set_types
  paginates_per 48
  validates :name, uniqueness: true

  def get_price(user)
    self.set_prices.find_by(user_id: user.id).price
    rescue
      nil
  end

  def promo(user)
    discount = user.promotions.joins(:products).where("products.id = ?", self.id).distinct.pluck(:discount).min
    if discount
      price =  discount * self.get_price(user)
      return {price: price, discount: discount}
    else
      return {price: nil, discount: nil}
    end
  end

  def self.search(query, current_user, sort_by)
    product = (current_user.products.where("lower(products.name) LIKE ? OR lower(products.description) LIKE ? OR lower(products.set_name) LIKE ?", "%#{query.downcase}%", "%#{query.downcase}%", "%#{query.downcase}%") || current_user.products.joins(:brand).where("lower(brands.name) LIKE ?", "%#{query.downcase}%") ||
    current_user.products.joins(:categories).where("lower(categories.name) LIKE ?", "%#{query.downcase}%") ||
    current_user.products.joins(:product_items).where("lower(product_items.name) LIKE ?", "%#{query.downcase}%"))

    mattresses = current_user.mattresses.where("lower(name) LIKE ?", "%#{query.downcase}%")
    {products: product, mattresses: mattresses}
  end

  def set_related_products

  end
end
