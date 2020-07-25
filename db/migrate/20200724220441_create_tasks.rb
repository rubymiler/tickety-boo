class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.references :assigner, references: :users, foreign_key: { to_table: :users }
      t.references :assignee, references: :users, foreign_key: { to_table: :users}

      t.references :ticket, null: false, foreign_key: true
      t.string :description
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
