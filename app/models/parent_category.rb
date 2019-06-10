class ParentCategory < ApplicationRecord
  has_many :categories
  has_many :products, through: :categories
  belongs_to :user
end
