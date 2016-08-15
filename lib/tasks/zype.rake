# frozen_string_literal: true
namespace :zype do
  desc 'Fetch all videos from Zype and update them'
  task refresh_videos: :environment do
    VideoGateway.refresh_all!
  end
end
