class CreatePostTopics < ActiveRecord::Migration[6.0]
  def change
    create_table :post_topics do |t|
      t.references :topic, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
    end
  end
end
