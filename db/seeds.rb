ActiveRecord::Base.transaction do
  user1 = User.create(email: 'johndoe@example.com', password: 'password123')
  user2 = User.create(email: 'janesmith@example.com', password: 'password456')
  User.create(email: 'bobjohnson@example.com', password: 'password789')

  item1 = Item.create(name: 'Coffee', price: 2.5, tax_rate: 0.10,
                      discount_type: Constants::DISCOUNT_TYPES[:none], discount_amount: 0)
  item2 = Item.create(name: 'Sandwich', price: 5.0, tax_rate: 0.15,
                      discount_type: Constants::DISCOUNT_TYPES[:fixed_amount], discount_amount: 1.0)
  item3 = Item.create(name: 'Muffin', price: 2.0, tax_rate: 0.10,
                      discount_type: Constants::DISCOUNT_TYPES[:percentage], discount_amount: 30)

  Item.create(name: 'Juice', price: 3.0, tax_rate: 0.10, discount_type: Constants::DISCOUNT_TYPES[:percentage],
              discount_amount: 100)

 # Creating deals
  deal1 = Deal.create(name: 'Deal 1', description: 'Coffee and Sandwich deal', start_date: Time.current, end_date: Time.current + 1.month)
  deal2 = Deal.create(name: 'Deal 2', description: 'Sandwich and Muffin deal', start_date: Time.current, end_date: Time.current + 1.month)
  deal = Deal.create(name: 'Combo Deal', description: 'Combo offer on coffee, sandwich, and muffin',
                  start_date: Time.zone.now, end_date: Time.zone.now + 1.month, overall_discount: 15)


  DealItem.create(deal: deal1, item: item1, deal_price: item1.price - 1.0) # Assuming a discount for deal price
  DealItem.create(deal: deal1, item: item2, deal_price: item2.price - 1.5) # Assuming a discount for deal price
  DealItem.create(deal: deal2, item: item2, deal_price: item2.price - 2.0) # Assuming a discount for deal price
  DealItem.create(deal: deal2, item: item1, deal_price: item1.price - 2.0)

  # Associate items with the deal
  DealItem.create(deal: deal, item: item1, deal_price: 5.0)
  DealItem.create(deal: deal, item: item2, deal_price: 8.0)
  DealItem.create(deal: deal, item: item3, deal_price: 4.0)

  Order.create(user: user1, status: 'completed', order_items: [OrderItem.new(item: item1, quantity: 2),
                                                               OrderItem.new(item: item2, quantity: 1)])
  Order.create(user: user2, order_items: [OrderItem.new(item: item2, quantity: 3),
                                          OrderItem.new(item: item3, quantity: 2)])
  Order.create(user: user1, order_items: [OrderItem.new(item: item1, quantity: 2)])
  Order.create(user: user2, order_items: [OrderItem.new(item: item2, quantity: 3)])
end
