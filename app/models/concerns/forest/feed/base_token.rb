module Forest::Feed
  module BaseToken
    extend ActiveSupport::Concern

    included do
      validates :service, :username, :code, presence: true

      scope :instagram, -> { where(service: 'Instagram') }
      scope :for_username, -> (username_id) { where(username: username_id) }
      scope :latest, -> { order(updated_at: :desc).limit(1) }
    end

    class_methods do
      def resource_description
        'A secret token is necessary to connect to the Instagram API. Typically this token only needs to be generated once, during the initial installation of the website.'
      end

      def usernames
        Forest::Feed::Token.instagram.distinct.pluck(:username)
      end
    end
  end
end
