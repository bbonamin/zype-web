# frozen_string_literal: true
class SessionsController < ApplicationController
  CLIENT_ID = '***REMOVED***'
  CLIENT_SECRET = '***REMOVED***'

  def create
    response = HTTParty.post(login_url)
    case response.code
    when 200 then response
    when 401 then render_new_with_error('Wrong username or password. Please try again.') && return
    else render_new_with_error('Unexpected server error. Please try again later.') && return
    end

    session[:access_token] = response.fetch('access_token')
    redirect_to video_url(Video.first) # TODO: CHANGE
  end

  def destroy
  end

  private

  def render_new_with_error(msg)
    flash[:error] = msg
    render(:new)
  end

  def login_url
    URI::HTTPS.build(
      host: 'login.zype.com', path: '/oauth/token/',
      query: {
        client_id: CLIENT_ID,
        client_secret: CLIENT_SECRET,
        username: params['username'],
        password: params['password'],
        grant_type: 'password'
      }.to_query
    )
  end
end
