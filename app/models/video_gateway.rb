# frozen_string_literal: true
class VideoGateway
  include HTTParty
  base_uri 'https://api.zype.com'

  def initialize(app_key = ZYPE_APP_KEY)
    @options = { query: { app_key: app_key } }
  end

  def all
    raw = self.class.get('/videos', @options)
    raw.fetch('response')
  end
end
