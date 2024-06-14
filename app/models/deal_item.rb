class DealItem < ApplicationRecord
  belongs_to :deal
  belongs_to :item
end