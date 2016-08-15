# frozen_string_literal: true
module VideosHelper
  def app_key
    Rails.application.secrets.zype_app_key
  end
end
