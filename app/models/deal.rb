class Deal < ApplicationRecord
  has_many :deal_items, dependent: :destroy
  has_many :items, through: :deal_items

  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  after_save :update_total_price_if_multiple_items

  accepts_nested_attributes_for :deal_items, allow_destroy: true

  private

  def update_total_price_if_multiple_items
    if deal_items.count > 1
      update_columns(total_price: items.sum(:price))
    end
  end
end