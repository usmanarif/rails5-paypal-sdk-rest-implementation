class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.integer :category_id
      t.string :name
      t.decimal :price
      t.string :description

      t.timestamps
    end
  end
end
