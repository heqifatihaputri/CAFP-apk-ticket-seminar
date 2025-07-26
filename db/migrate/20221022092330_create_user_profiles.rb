class CreateUserProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :user_profiles do |t|
      t.string  :user_uid
      t.string  :full_name
      t.string  :nric
      t.date    :dob
      t.integer :gender
      t.integer :marital_status
      t.string  :company
      t.string  :job
      t.text    :avatar_data
      t.string  :city
      t.string  :postcode
      t.string  :address
      t.string  :mobile_phone
      t.string  :home_number
      t.string  :facebook
      t.string  :instagram
      t.string  :linkedin

      t.references :user
      t.references :country

      t.timestamps
    end
  end
end
