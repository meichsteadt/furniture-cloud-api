class Mattress < ApplicationRecord
  belongs_to :brand
  has_and_belongs_to_many :materials
  has_and_belongs_to_many :users
  has_many :sizes

  def get_price(user, size)
    if size && size != "all"
      @size = self.sizes.find_by(user_id: user.id, name: size)
    else
      @size = self.sizes.find_by(user_id: user.id, name: "queen")
      unless @size
        @size = self.sizes.where(user_id: user.id).order(:price => :asc).first
      end
    end
    if @size
      {price: @size.price, name: @size.name}
    end
  end

  def get_prices(user)
    self.sizes.where(user_id: user.id)
  end

  def self.get_size(size, user_id)
    unless size === "all" || !size
      @mattresses = self.joins(:sizes).where(sizes: {name: size, user_id: user_id})
    else
      @mattresses = self.joins(:sizes).where(sizes: {user_id: user_id})
    end
    if @mattresses
      @mattresses.order("sizes.price desc")
    end
  end
end
