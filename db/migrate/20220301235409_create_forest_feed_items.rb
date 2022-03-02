class CreateForestFeedItems < ActiveRecord::Migration[7.0]
  def change
    create_table :forest_feed_items do |t|
      t.string :service
      t.string :username
      t.jsonb :data, default: {}

      t.timestamps
    end

    add_index :forest_feed_items, :service
    add_index :forest_feed_items, :username
    add_index :forest_feed_items, :data, using: :gin
  end
end
