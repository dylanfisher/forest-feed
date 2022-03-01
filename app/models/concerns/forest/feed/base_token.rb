module Forest::Feed
  module BaseToken
    extend ActiveSupport::Concern

    included do
      validates :service, :username, :code, presence: true
    end

    class_methods do
      def resource_description
        'A secret token is necessary to connect to the Instagram API. Typically this token only needs to be generated once, during the initial installation of the website.'
      end
    end
  end
end
