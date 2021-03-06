class CreateForestFeedItems < ActiveRecord::Migration[7.0]
  def change
    create_table :forest_feed_items do |t|
      t.string :service
      t.string :user_id
      t.string :user_display_name
      t.string :service_id
      t.jsonb :data, default: {}

      t.timestamps
    end

    add_index :forest_feed_items, :service
    add_index :forest_feed_items, :user_id
    add_index :forest_feed_items, :user_display_name
    add_index :forest_feed_items, :service_id
    add_index :forest_feed_items, :data, using: :gin
    add_index :forest_feed_items,  "(data -> 'timestamp')", using: :gin, name: 'index_forest_feed_items_on_data_timestamp'
  end
end
