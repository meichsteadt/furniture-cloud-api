class Category < ApplicationRecord
  has_and_belongs_to_many :products
  has_many :products_users, :through => :products, source: :products_users
  has_and_belongs_to_many :users
  belongs_to :parent_category
  has_many :init_models, as: :init_modelable
  has_many :set_types

  def self.defaults
    self.joins(:init_models)
  end
end
