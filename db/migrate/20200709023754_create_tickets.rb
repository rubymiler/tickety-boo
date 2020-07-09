class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :description
      t.boolean :public
      t.references :submitter, references: :users, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
