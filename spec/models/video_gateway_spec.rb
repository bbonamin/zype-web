# frozen_string_literal: true
require 'rails_helper'

RSpec.describe VideoGateway, type: :model do
  describe '#fetch' do
    it 'responds with a collection of video-like hashes' do
      VCR.use_cassette 'video_gateway_page1', allow_playback_repeats: true do
        page_1 = subject.fetch
        expect(page_1.current_page).to eq(1)

        videos = page_1.all
        expect(videos).to be_kind_of Array

        a_video = videos.first
        expect(a_video['title']).not_to be_nil
        expect(a_video['_id']).not_to be_nil
        expect(a_video['description']).not_to be_nil
      end
    end

    it 'fetches videos from a given page if it is specified' do
      VCR.use_cassette 'video_gateway_page_2', allow_playback_repeats: true do
        page_2 = subject.fetch(page: 2)

        expect(page_2.current_page).to eq(2)
        videos = page_2.all
        expect(videos).to be_kind_of Array

        a_video = videos.first
        expect(a_video['title']).not_to be_nil
        expect(a_video['_id']).not_to be_nil
        expect(a_video['description']).not_to be_nil
      end
    end
  end
end
