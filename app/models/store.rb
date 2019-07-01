class Store < ApplicationRecord
  belongs_to :user
  has_many :images
  has_many :deliveries
  has_many :reviews
  has_many :locations
  belongs_to :color_pallete
  has_secure_password
end
