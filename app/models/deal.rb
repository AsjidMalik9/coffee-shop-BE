class Deal < ApplicationRecord
  has_many :deal_items, dependent: :destroy
  has_many :items, through: :deal_items

  accepts_nested_attributes_for :deal_items, allow_destroy: true
end