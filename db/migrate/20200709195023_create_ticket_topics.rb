class CreateTicketTopics < ActiveRecord::Migration[6.0]
  def change
    create_table :ticket_topics do |t|
      t.references :ticket, null: false, foreign_key: true
      t.references :topic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
