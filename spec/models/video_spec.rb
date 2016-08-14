# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Video, type: :model do
  describe '.refresh_all!' do
    it 'creates as videos as hashes in VideoGateway#all' do
      VCR.use_cassette 'video_gateway_all', allow_playback_repeats: true do
        video_gateway = VideoGateway.new
        expect { Video.refresh_all! }.to change(Video, :count).from(0).to(video_gateway.all.size)
      end
    end
  end
end
