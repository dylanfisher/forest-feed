module Forest
  module Feed
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
