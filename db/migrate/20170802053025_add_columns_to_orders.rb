class AddColumnsToOrders < ActiveRecord::Migration[5.0]
  def change
  	add_column :orders, :payment_method, :string
  	add_column :orders, :sale_id, :integer
  	add_column :orders, :status, :string
  	add_column :orders, :amount, :float
  	add_column :orders, :description, :string
  	add_column :orders, :donor_id, :integer
  end
end
