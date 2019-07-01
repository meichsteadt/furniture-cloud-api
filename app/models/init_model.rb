class InitModel < ApplicationRecord
  belongs_to :init_modelable, polymorphic: true
end
