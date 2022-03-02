class CreateForestFeedMediaAssets < ActiveRecord::Migration[7.0]
  def change
    create_table :forest_feed_media_assets do |t|
      t.references :forest_feed_item, null: false, foreign_key: true
      t.references :media_item, null: false, foreign_key: true

      t.timestamps
    end

    add_column :forest_feed_media_assets, :position, :integer, default: 0, null: false
    add_index :forest_feed_media_assets, :position
  end
end
