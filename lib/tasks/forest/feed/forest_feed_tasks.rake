namespace :forest do
  namespace :feed do
    desc 'Sync feed items for all unique token users.'
    task :sync => :environment do
      Forest::Feed::SyncItemsJob.perform_now
    end
  end
end
