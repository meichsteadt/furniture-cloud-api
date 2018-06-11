class Store < ApplicationRecord
  belongs_to :user
  has_many :images
  has_many :deliveries
  has_many :reviews

end
