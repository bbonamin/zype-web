# frozen_string_literal: true
class VideoGateway
  include HTTParty
  base_uri 'https://api.zype.com'

  def initialize(app_key: Rails.application.secrets.zype_app_key)
    @options = { query: { app_key: app_key } }
  end

  def fetch(page: 1)
    options = @options.deep_merge(query: { page: page })
    Page.new(self.class.get('/videos', options))
  end

  class Page
    attr_reader :response

    def initialize(response)
      @response = response
    end

    def current_page
      @response.fetch('pagination').fetch('current')
    end

    def max_pages
      @response.fetch('pagination').fetch('pages')
    end

    def all
      @response.fetch('response')
    end

    def each
      all.each
    end
  end
end
