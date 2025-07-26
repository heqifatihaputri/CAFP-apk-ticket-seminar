class CreateCartItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      t.integer :quantity

      t.references :cart
      t.references :event
      t.references :ticket_stock

      t.timestamps
    end
  end
end
