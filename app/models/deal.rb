class Deal < ApplicationRecord
  has_many :deal_items, dependent: :destroy
  has_many :items, through: :deal_items

  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  accepts_nested_attributes_for :deal_items, allow_destroy: true

  def update_total_price
    total = deal_items.sum(:deal_price)
    update_column(:total_price, total)
  end
end