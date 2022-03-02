module Forest::Feed
  module BaseItem
    extend ActiveSupport::Concern

    # The media URLs for a feed item hosted on Instagram's CDN change. We only need to sync the media URL on initial sync.
    IGNORED_SUBSEQUENT_SYNC_ATTRIBUTES = ['media_url']

    included do
      after_commit :create_associated_media_assets, on: :create

      has_many :media_assets, -> { order('forest_feed_media_assets.position ASC') }, class_name: 'Forest::Feed::MediaAsset', foreign_key: 'forest_feed_item_id', dependent: :destroy
      has_many :media_items, through: :media_assets

      has_one :featured_media_asset, -> { where(position: 0) }, foreign_key: :forest_feed_item_id, class_name: 'Forest::Feed::MediaAsset'
      has_one :featured_media_item, through: :featured_media_asset, source: :media_item

      scope :by_post_date, -> { order(Arel.sql("data -> 'timestamp'::text DESC")) }
    end

    class_methods do
      def resource_description
        'A feed item is created to represent each individual post from your feed.'
      end

      def sync_all(token)
        client = Forest::Feed::Instagram::Client.new(token)

        instagram_media_items = JSON.parse(client.media.body)['data']
        service_ids = instagram_media_items.collect { |item| item['id'] }
        record_cache = Forest::Feed::Item.where(service_id: service_ids)

        instagram_media_items.each do |instagram_media_item|
          service_id = instagram_media_item['id']

          forest_feed_item = record_cache.find { |r|
            r.service == 'Instagram' &&
            r.username == token.username &&
            r.service_id == service_id
          }.presence || Forest::Feed::Item.find_or_initialize_by({
            service: 'Instagram',
            username: token.username,
            service_id: service_id
          })

          attributes_to_ignore = forest_feed_item.new_record? ? [] : IGNORED_SUBSEQUENT_SYNC_ATTRIBUTES

          instagram_media_item.keys.excluding(attributes_to_ignore).each do |key|
            forest_feed_item.data[key] = instagram_media_item[key]
          end

          forest_feed_item.save! if forest_feed_item.changed?
        end

        client.refresh_access_token!
      end
    end

    def image?
      data['media_type'] == 'IMAGE'
    end

    def video?
      data['media_type'] == 'VIDEO'
    end

    def carousel?
      data['media_type'] == 'CAROUSEL_ALBUM'
    end

    def media_urls
      if data['children'].present?
        data['children']['data'].collect { |c| c['media_url'] }
      else
        Array(data['media_url'])
      end
    end

    def featured_media_url
      media_urls.first
    end

    def create_associated_media_assets
      media_urls.each_with_index do |media_url, index|
        media_item = MediaItem.new({
          title: "Feed item #{self.id} - asset #{index + 1}",
          media_item_status: 'hidden'
        })
        media_item.attachment = uploader.upload(URI.open(media_url))
        media_asset = media_assets.build({
          media_item: media_item,
          position: index
        })
        media_asset.save!
      end
    end

    private

    def uploader
      @uploader ||= FileUploader.new(:cache)
    end
  end
end
