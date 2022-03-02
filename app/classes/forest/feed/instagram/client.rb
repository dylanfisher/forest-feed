require 'faraday'

module Forest::Feed::Instagram
  class Client
    API_VERSION = 'v13.0'

    attr_accessor :connection
    attr_accessor :user_id
    attr_accessor :token

    def initialize(token)
      @token = token
      @user_id = token.user_id
      @connection = Faraday.new(
        url: "https://graph.instagram.com/#{API_VERSION}",
        params: { access_token: token.code }
      )
    end

    # https://developers.facebook.com/docs/instagram-basic-display-api/reference/me
    def me
      @me ||= connection.get('me', {
        fields: 'id,username'
      })
    end

    # https://developers.facebook.com/docs/instagram-basic-display-api/reference/user/media
    def media
      @media ||= connection.get("#{@user_id}/media", {
        fields: 'caption,id,media_type,media_url,permalink,timestamp,children{id,media_type,media_url,timestamp,username}'
      })
    end

    # https://developers.facebook.com/docs/instagram-basic-display-api/reference/refresh_access_token
    def refresh_access_token!
      response = connection.get('/refresh_access_token', {
        grant_type: 'ig_refresh_token'
      })

      unless response.success?
        Rails.logger.error { "[Forest][Error] error refreshing Instagram Access Token" }
        return
      end

      body = JSON.parse(response.body)
      new_token = body['access_token']

      if new_token.blank?
        Rails.logger.error { "[Forest][Error] error refreshing Instagram Access Token" }
        return
      end

      token.update(code: new_token)
    end
  end
end
