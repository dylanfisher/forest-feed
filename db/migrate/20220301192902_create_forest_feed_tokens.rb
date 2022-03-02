class CreateForestFeedTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :forest_feed_tokens do |t|
      t.string :service
      t.string :username
      t.string :code

      t.timestamps
    end

    add_index :forest_feed_tokens, :service
    add_index :forest_feed_tokens, :username
  end
end
