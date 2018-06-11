class Mattress < ApplicationRecord
  belongs_to :brand
  has_and_belongs_to_many :materials
end
