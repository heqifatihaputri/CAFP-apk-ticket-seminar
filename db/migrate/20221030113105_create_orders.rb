class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.decimal :total
      t.string  :phone_number
      t.string  :recepient_name
      t.string  :payment_method
      t.string  :status
      t.string  :remark
      t.boolean :use_balance, default: false
      t.decimal :use_balance_amount
      t.string  :order_uid

      t.references :user

      t.timestamps
    end
  end
end
