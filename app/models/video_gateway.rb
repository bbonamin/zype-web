# frozen_string_literal: true
class VideoGateway
  include HTTParty
  base_uri 'https://api.zype.com'

  def initialize(app_key: Rails.application.secrets.zype_app_key)
    @options = { query: { app_key: app_key } }
  end

  def self.refresh_all!
    video_gateway = new
    page_number = 1
    loop do
      page = video_gateway.fetch(page: page_number)
      Video.create_or_update_from_page!(page)

      break unless page.current_page <= page.max_pages
      page_number = page.current_page + 1
    end
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
  end
end
