module Forest::Feed
  module BaseItem
    extend ActiveSupport::Concern

    # The media URLs for a feed item hosted on Instagram's CDN change. We only need to sync the media URL on initial sync.
    IGNORED_SUBSEQUENT_SYNC_ATTRIBUTES = ['media_url']

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
            next if attributes_to_ignore.include?(key)

            forest_feed_item.data[key] = instagram_media_item[key]
          end

          forest_feed_item.save! if forest_feed_item.changed?
        end

        client.refresh_access_token!
      end
    end
  end
end
