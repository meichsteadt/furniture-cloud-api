class ParentCategory < ApplicationRecord
  has_many :categories
  has_many :products, through: :categories
  has_many :init_models, as: :init_modelable
  belongs_to :user
end
