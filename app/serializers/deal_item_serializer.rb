class DealItemSerializer
  include JSONAPI::Serializer

  attributes :id, :deal_price
  

  belongs_to :deal
  belongs_to :item
end
