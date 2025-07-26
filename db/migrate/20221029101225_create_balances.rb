class CreateBalances < ActiveRecord::Migration[7.0]
  def change
    create_table :balances do |t|
      t.date    :period
      t.decimal :previous_mutation, default: 0
      t.decimal :current_mutation, default: 0

      t.references :user

      t.timestamps
    end
  end
end
