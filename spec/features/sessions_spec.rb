# frozen_string_literal: true
# frozen_string_literal: true
require 'rails_helper'

describe 'Logging in' do
  it 'allows logging in and redirects back to the videos index page' do
    visit new_session_url

    fill_in 'Username', with: 'test@test.com'
    fill_in 'Password', with: 'password'
    VCR.use_cassette 'zype_session' do
      click_button 'Log in'
    end

    expect(page.current_url).to eq(videos_url)
    expect(page.text).to include('Logged in successfully.')
  end

  it 'shows an error message if incorrect credentials are used to log in' do
    visit new_session_url

    fill_in 'Username', with: 'foo@bar.com'
    fill_in 'Password', with: 'asdf09123'
    VCR.use_cassette 'zype_unauthorized_session' do
      click_button 'Log in'
    end

    expect(page.text).to include('Wrong username or password')
  end
end
