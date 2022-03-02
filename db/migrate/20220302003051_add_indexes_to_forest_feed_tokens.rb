class AddIndexesToForestFeedTokens < ActiveRecord::Migration[7.0]
  def change
    add_index :forest_feed_tokens, :service
    add_index :forest_feed_tokens, :username
  end
end
