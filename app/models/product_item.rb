class ProductItem < ApplicationRecord
  belongs_to :product
  has_many :prices

  def get_price(user)
    self.prices.find_by(user_id: user.id).price
    rescue
      self.price
  end
end
