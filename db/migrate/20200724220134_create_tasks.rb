class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :description
      t.user :references
      t.ticket :references
      t.boolean :completed

      t.timestamps
    end
  end
end
