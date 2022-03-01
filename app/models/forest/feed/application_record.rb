module Forest
  module Feed
    class ApplicationRecord < Forest::ApplicationRecord
      self.abstract_class = true
    end
  end
end
