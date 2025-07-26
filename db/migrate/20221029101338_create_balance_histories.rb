class CreateBalanceHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :balance_histories do |t|
      t.decimal :amount, default: 0
      t.integer :status, default: 0
      t.date    :trans_date
      t.text    :description

      t.references :balance
      t.references :source, :polymorphic => true

      t.timestamps
    end
  end
end
