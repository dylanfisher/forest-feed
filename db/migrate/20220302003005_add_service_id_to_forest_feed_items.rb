class AddServiceIdToForestFeedItems < ActiveRecord::Migration[7.0]
  def change
    add_column :forest_feed_items, :service_id, :string
    add_index :forest_feed_items, :service_id
  end
end
