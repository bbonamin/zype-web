# frozen_string_literal: true
class Video < ApplicationRecord
  default_scope -> { order(:title) }

  def self.refresh_all!
    video_gateway = VideoGateway.new
    video_gateway.all.each do |video_hash|
      video = find_or_initialize_by(zype_id: video_hash.fetch('_id'))
      video.attributes = {
        title: video_hash.fetch('title'),
        raw_payload: video_hash
      }
      video.save!
    end
  end

  def first_thumbnail_url
    thumbnails.first.fetch('url')
  end

  def thumbnails
    raw_payload.fetch('thumbnails') { raise 'Video does not contain thumbnails' }
  end
end
