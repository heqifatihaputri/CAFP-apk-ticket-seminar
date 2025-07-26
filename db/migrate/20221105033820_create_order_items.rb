class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.integer :quantity
      t.decimal :price
      t.string  :product_name
      t.text    :product_details

      t.references :order
      t.references :order_temp
      t.references :event
      t.references :ticket_stock

      t.timestamps
    end
  end
end
