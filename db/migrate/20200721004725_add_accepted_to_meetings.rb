class AddAcceptedToMeetings < ActiveRecord::Migration[6.0]
  def change
    add_column :meetings, :accepted, :boolean, default: false
  end
end
