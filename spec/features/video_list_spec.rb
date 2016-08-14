require 'rails_helper'

describe 'Visiting the video list', type: :feature do
  before :each do
    VCR.use_cassette('video_gateway_all') { Video.refresh_all! }
    visit videos_url
  end

  it 'displays all videos' do
    expect(all('.video-item').size).to eq(Video.count)
  end

  it 'displays the video title' do
    within('.video-item:first') do
      expect(page.text).to eq(Video.first.title)
    end
  end

  it 'displays the video thumbnail' do
    within('.video-item:first') do
      thumbnail_url = Video.first.first_thumbnail_url
      expect(page.find('img')[:src]).to eq(thumbnail_url)
    end
  end
end
