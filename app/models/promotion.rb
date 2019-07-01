class Promotion < ApplicationRecord
  has_and_belongs_to_many :products
  has_many :init_models, as: :init_modelable
  belongs_to :user
end
