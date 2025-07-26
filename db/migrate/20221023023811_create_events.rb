class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string   :name
      t.text     :description
      t.datetime :start_time
      t.datetime :end_time
      t.string   :speaker
      t.datetime :published_date
      t.string   :platform_url
      t.boolean  :ticket_start_selling, default: true

      t.references :venue

      t.timestamps
    end
  end
end
