# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Video, type: :model do
  describe '.create_or_update_from_page!' do
    it 'creates videos as hashes in VideoGateway#all' do
      VCR.use_cassette 'video_gateway_page1', allow_playback_repeats: true do
        video_gateway = VideoGateway.new
        page = video_gateway.fetch
        expect { Video.create_or_update_from_page!(page) }.to change(Video, :count).from(0).to(10)
      end
    end
  end
end
