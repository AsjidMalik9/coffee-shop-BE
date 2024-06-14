class CreateDealsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :deals do |t|
      t.string "name", null: false
      t.text "description"
      t.datetime "start_date", null: false
      t.datetime "end_date", null: false
      t.decimal "overall_discount", precision: 10, scale: 2

      t.timestamps
    end
  end
end
