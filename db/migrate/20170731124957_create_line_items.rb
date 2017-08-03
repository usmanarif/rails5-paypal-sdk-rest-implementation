class CreateLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :line_items do |t|
      t.decimal :unit_price
      t.integer :product_id
      t.integer :cart_id
      t.integer :quantity

      t.timestamps
    end
  end
end
