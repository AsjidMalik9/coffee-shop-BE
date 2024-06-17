
## Prerequisites

- Ruby 3.1.2
- Rails 7.0.5
- PostgreSQL 12.15

## Getting Started

1. Navigate to the project directory: `cd coffee-shop`
2. Install the required gems: `bundle install`
3. Create the database: `rails db:create`
4. Run the database migrations: `rails db:migrate`
5. Seed the database with sample data: `rails db:seed`
6. Start the server: `rails s`


Sample deal payload:

{
    "name": "Deal 1 postman",
     "description": "postman descp",
    "overall_discount": 1,
    "start_date": "14th June Friday",
    "end_date": "14th July Sunday",
    "deal_items_attributes": [
      { "item_id": 17, "deal_price": 4.99 },
      { "item_id": 21, "deal_price": 6.49 }
    ]
}

Samle Order payload:

{
    "status": "pending",
    "order_items_attributes": [
        { "item_id": 17, "quantity": 2 },
        { "item_id": 21, "quantity": 1 }
    ]
}




