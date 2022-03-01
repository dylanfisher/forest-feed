module Forest
  module Feed
    class Engine < ::Rails::Engine
      isolate_namespace Forest::Feed
    end
  end
end
