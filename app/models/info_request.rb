class InfoRequest < ApplicationRecord
  belongs_to :product
  belongs_to :store
  belongs_to :customer, optional: true
end
