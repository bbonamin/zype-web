# frozen_string_literal: true
class VideosController < ApplicationController
  def index
    @videos = Video.all
  end

  def show
    @video = Video.find(params[:id])
  end

  def access_token
    session[:access_token]
  end
  helper_method :access_token
end
