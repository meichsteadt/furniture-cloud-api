class Brand < ApplicationRecord
  has_many :products
  has_many :mattresses
  has_many :init_models, as: :init_modelable
  
end
