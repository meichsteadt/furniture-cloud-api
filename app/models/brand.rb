class Brand < ApplicationRecord
  has_many :products
  has_many :mattresses
  has_many :init_models, as: :init_modelable

  def self.defaults
    self.joins(:init_models)
  end
end
