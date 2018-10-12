class ParentCategory < ApplicationRecord
  has_many :categories
  belongs_to :user
end
