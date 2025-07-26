class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.string   :trans_id
      t.decimal  :total
      t.text     :detail
      t.text     :remark
      t.string   :status
      t.datetime :paydate
      t.string   :invoice_uid

      t.references :user
      t.references :order

      t.timestamps
    end
  end
end
