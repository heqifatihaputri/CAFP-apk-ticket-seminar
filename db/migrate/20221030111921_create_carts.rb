class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.integer :cart_items_count, default: 0

      t.references :user

      t.timestamps
    end
  end
end
