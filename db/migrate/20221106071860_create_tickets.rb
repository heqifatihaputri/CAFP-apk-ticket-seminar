class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.string :attendee_name
      t.string :remark
      t.string :link_token
      t.string :fake_email
      t.string :code
      t.string :visitor_id
      t.text   :api_response

      t.references :last_ticket_session, foreign_key: { to_table: :ticket_sessions }
      t.references :event
      t.references :order_item
      t.references :ticket_stock
      t.references :ownership, class_name: "User"

      t.timestamps
    end
  end
end
