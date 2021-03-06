# frozen_string_literal: true
class Video < ApplicationRecord
  default_scope -> { order(:title) }

  def self.create_or_update_from_page!(page)
    page.all.each do |video_hash|
      Video.create_or_update_from_hash!(video_hash)
    end
  end

  def self.create_or_update_from_hash!(video_hash)
    video = find_or_initialize_by(zype_id: video_hash.fetch('_id'))
    video.attributes = {
      title: video_hash.fetch('title'),
      subscription_required: video_hash.fetch('subscription_required'),
      raw_payload: video_hash
    }
    video.save!
  end

  # The 4th thumbnail on each video has a decent enough size.
  def thumbnail
    thumbnails[3]
  end

  def thumbnails
    raw_payload.fetch('thumbnails')
  end
end
