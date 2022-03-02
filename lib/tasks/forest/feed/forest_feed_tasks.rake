namespace :forest do
  namespace :feed do
    desc 'Sync feed items for all unique token users.'
    task :sync => :environment do
      Forest::Feed::Token.usernames.each do |username|
        Forest::Feed::SyncItemsJob.perform_now(username)
      end
    end
  end
end
