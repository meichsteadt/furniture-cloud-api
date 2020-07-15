class Ahoy::Visit < ApplicationRecord
  self.table_name = "ahoy_visits"

  has_many :events, class_name: "Ahoy::Event"
  belongs_to :customer, optional: true
  has_one :cart
  belongs_to :user, optional: true
end
