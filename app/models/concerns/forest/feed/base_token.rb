module Forest::Feed
  module BaseToken
    extend ActiveSupport::Concern

    included do
      validates :service, :user_id, :user_display_name, :code, presence: true

      scope :instagram, -> { where(service: 'Instagram') }
      scope :for_username, -> (username) { where(user_display_name: username) }
      scope :latest, -> { order(updated_at: :desc).limit(1) }
    end

    class_methods do
      def resource_description
        'A secret token is necessary to connect to the Instagram API. Typically this token only needs to be generated once, during the initial installation of the website.'
      end

      def usernames
        Forest::Feed::Token.instagram.distinct.pluck(:user_display_name)
      end
    end
  end
end
