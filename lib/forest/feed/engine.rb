module Forest
  module Feed
    class Engine < ::Rails::Engine
      isolate_namespace Forest::Feed

      initializer 'forest-feed.checking_migrations' do
        Migrations.new(config, engine_name).check
      end
    end
  end
end
