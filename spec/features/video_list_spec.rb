# frozen_string_literal: true
require 'rails_helper'

describe 'Visiting the video list', type: :feature do
  before :each do
    VCR.use_cassette('video_gateway_page1') do
      video_gateway = VideoGateway.new
      page = video_gateway.fetch
      Video.create_or_update_from_page!(page)
    end

    visit videos_url
  end

  it 'displays the first page of videos' do
    expect(all('.video-item').size).to eq(9)
  end

  it 'displays the video title' do
    within(first('.video-item')) do
      expect(page.text).to eq(Video.first.title)
    end
  end

  it 'displays the video thumbnail' do
    within(first('.video-item')) do
      url = Video.first.thumbnail.fetch('url')
      expect(page.find('img')[:src]).to eq(url)
    end
  end

  it 'navigates to the video details when clicked' do
    first('a.video-item-link').click
    expect(page.current_url).to eq(video_url(Video.first))
  end
end
