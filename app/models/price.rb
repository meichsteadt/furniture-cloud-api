class Price < ApplicationRecord
  belongs_to :user
  belongs_to :product_item
  has_many :init_models, as: :init_modelable
  validates :user_id, uniqueness: {scope: :product_item_id}

  def self.defaults
    self.joins(:init_models)
  end
end
