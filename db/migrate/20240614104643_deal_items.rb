class DealItems < ActiveRecord::Migration[7.0]
  def change
    create_table :deal_items do |t|
      t.references "deal", null: false, foreign_key: true
      t.references "item", null: false, foreign_key: true
      t.decimal "deal_price", precision: 10, scale: 2, null: false
      t.decimal "deal_discount", precision: 10, scale: 2

      t.timestamps
    end

    add_index :deal_items, %i[item_id deal_id], unique: true
  end
end
