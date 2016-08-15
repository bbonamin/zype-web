#frozen# frozen_string_literal: true
module VideosHelper
  # Returns a image_tag helper friendly size option
  # e.g. (15x10)
  def size_for_thumbnail(thumbnail)
    width = thumbnail.fetch('width')
    height = thumbnail.fetch('height')
    "#{width}x#{height}"
  end
end
