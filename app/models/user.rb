class User < ApplicationRecord
  has_secure_password
  has_many :stores
  has_many :parent_categories
  has_and_belongs_to_many :products
  has_and_belongs_to_many :mattresses
  has_many :promotions
  has_and_belongs_to_many :categories
  has_many :brands, through: :products
  has_many :prices
  has_many :set_prices
  has_many :financings
  has_one :user_key
  has_many :views, class_name: "Ahoy::Event"
  validates :email, uniqueness: true
  validates :markup_default, presence: true
  validates :password, :length => {minimum: 6}, :on => :create

  def load_defaults
    self.products << Product.defaults
    self.categories << Category.defaults
    self.parent_categories << ParentCategory.defaults
    Promotion.where(id: InitModel.where(init_modelable_type: "Promotion").pluck(:init_modelable_id)).each do |promo|
      @promo = self.promotions.create(promo.attributes.reject {|e| ["id", "user_id", "created_at", "update_at"].include?(e) })
      @promo.products << promo.products
    end
  end

  def create_prices
    SetPrice.defaults.each do |set_price|
      self.set_prices.create(product_id: set_price.product_id, price: set_price.price * self.markup_default)
    end
    Price.defaults.each do |price|
      self.prices.create(product_item_id: price.product_item_id, price: price.price * self.markup_default)
    end
  end

  def self.create_with_defaults(params)
    user = User.create(
      name: params[:name],
      password: params[:password],
      email: params[:email],
      google_analytics: params[:google_analytics],
      markup_default: params[:markup_default],
    )
    user.load_defaults
    user.create_prices
  end

  def remove_5pc_sets

  end
end
