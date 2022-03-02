module Forest::Feed
  class MediaAsset < ApplicationRecord
    belongs_to :forest_feed_item, class_name: 'Forest::Feed::Item', touch: true
    belongs_to :media_item, touch: true, dependent: :destroy
  end
end
