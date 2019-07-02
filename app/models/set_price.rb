class SetPrice < ApplicationRecord
  belongs_to :product
  belongs_to :user
  has_many :init_models, as: :init_modelable
  validates :user_id, uniqueness: {scope: :product_id}

  def self.defaults
    self.joins(:init_models)
  end
end
