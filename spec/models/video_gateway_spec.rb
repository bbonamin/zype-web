# frozen_string_literal: true
require 'rails_helper'

RSpec.describe VideoGateway, type: :model do
  describe '#all' do
    it 'responds with a collection of video-like hashes' do
      VCR.use_cassette 'video_gateway_all', allow_playback_repeats: true do
        all_videos = subject.all
        expect(all_videos).to be_kind_of Array

        a_video = all_videos.first
        expect(a_video['title']).not_to be_nil
        expect(a_video['_id']).not_to be_nil
        expect(a_video['description']).not_to be_nil
      end
    end
  end
end
