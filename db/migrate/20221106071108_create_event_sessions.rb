class CreateEventSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :event_sessions do |t|
      t.string  :title
      t.integer :status, default: 0
      t.boolean :is_current, default: false

      t.references :event

      t.timestamps
    end
  end
end
