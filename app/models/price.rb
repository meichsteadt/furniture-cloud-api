class Price < ApplicationRecord
  belongs_to :user
  belongs_to :product_item
  has_many :init_models, as: :init_modelable
  validates :user_id, uniqueness: {scope: :product_item_id}
end
