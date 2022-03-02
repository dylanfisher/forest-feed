module Forest::Feed
  class SyncItemsJob < ApplicationJob
    queue_as :default

    def perform(user_id)
      begin
        token = Forest::Feed::Token.instagram.latest.for_username(user_id).first
        Forest::Feed::Item.sync_all(token)
      rescue Exception => e
        backtrace = e.backtrace.first(10).join("\n")
        Rails.logger.error { "[Forest][Error] Forest::Feed::Item.sync_all failed\n#{e.message}\n#{backtrace}" }
      end
    end
  end
end
