class CreateTicketStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :ticket_stocks do |t|
      t.string  :name
      t.string  :sku
      t.text    :description
      t.boolean :go_live, default: false
      t.string  :slug
      t.integer :quantity, default: 0
      t.decimal :price, default: 0
      t.date    :start_sale
      t.date    :end_sale
      t.integer :sold_quantity, default: 0
      t.integer :total_stock, default: 0

      t.references :event
      t.references :admin

      t.timestamps
    end
  end
end
