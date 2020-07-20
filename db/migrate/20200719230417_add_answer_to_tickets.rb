class AddAnswerToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :answer, :text
  end
end
