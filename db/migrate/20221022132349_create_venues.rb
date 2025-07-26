class CreateVenues < ActiveRecord::Migration[7.0]
  def change
    create_table :venues do |t|
      t.string :name
      t.string :city
      t.string :state
      t.string :postcode
      t.string :contact
      t.text   :full_address
      t.references :country

      t.timestamps
    end
  end
end
