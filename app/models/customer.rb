class Customer < ApplicationRecord
  belongs_to :store
  validates :email, uniqueness: true

end
