class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :commented_ticket, references: :tickets, foreign_key: { to_table: :tickets }
      t.references :commenter, references: :users, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
