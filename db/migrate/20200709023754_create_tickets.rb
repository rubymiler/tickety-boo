class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :body
      t.boolean :public

      t.timestamps
    end
  end
end
