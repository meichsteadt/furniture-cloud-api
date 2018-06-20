class User < ApplicationRecord
  has_secure_password
  has_many :stores
  has_and_belongs_to_many :products
  has_and_belongs_to_many :mattresses
  has_and_belongs_to_many :promotions
  has_and_belongs_to_many :categories
  has_many :brands, through: :products
  has_many :prices
  has_many :financings
  has_one :user_key
  validates :password, :length => {minimum: 6}, :on => :create
end
