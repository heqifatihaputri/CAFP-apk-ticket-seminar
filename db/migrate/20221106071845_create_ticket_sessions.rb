class CreateTicketSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :ticket_sessions do |t|
      t.datetime :in_time
      t.datetime :out_time
      t.string   :visitor_id_in
      t.string   :visitor_id_out

      t.references :ticket
      t.references :user
      t.references :event
      t.references :event_session

      t.timestamps
    end
  end
end
