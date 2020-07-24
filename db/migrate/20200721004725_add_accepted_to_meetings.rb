class AddAcceptedToMeetings < ActiveRecord::Migration[6.0]
  def change
    add_column :meetings, :status, :integer, default: 0
  end
end
