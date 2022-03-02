module Forest::Feed
  class SyncItemsJob < ApplicationJob
    queue_as :default

    def perform
      begin
        Forest::Feed::Token.usernames.each do |username|
          token = Forest::Feed::Token.instagram.latest.for_username(username).first
          Forest::Feed::Item.sync_all(token)
        end
      rescue Exception => e
        backtrace = e.backtrace.first(10).join("\n")
        Rails.logger.error { "[Forest][Error] Forest::Feed::Item.sync_all failed\n#{e.message}\n#{backtrace}" }
      end
    end
  end
end
