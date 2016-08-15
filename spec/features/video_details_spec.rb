# frozen_string_literal: true
require 'rails_helper'

describe 'Visiting a video details page', type: :feature do
  before :each do
    visit video_url(video)
  end

  context 'which does not require a subscription' do
    let(:video) do
      Video.create!(
        zype_id: '56a7b83169702d2f834bd9b7',
        title: 'Weekend Update 11-21-15, Part 1 of 2 - SNL',
        subscription_required: false,
        raw_payload: {
          'thumbnails' => [
            { 'url' => 'https://example.org/1.jpg' },
            { 'url' => 'https://example.org/2.jpg' },
            { 'url' => 'https://example.org/3.jpg' },
            { 'url' => 'https://example.org/4.jpg' }
          ],
          'description' => 'Hello World'
        }
      )
    end

    it 'displays the title & description' do
      expect(page.text).to include(video.title)
      expect(page.text).to include(video.raw_payload.fetch('description'))
    end

    it 'displays the video player' do
      expect(find('.video-player')).to be_present
    end
  end

  context 'which requires a subscription' do
    let(:video) do
      Video.create!(
        zype_id: '56a7b83269702d2f8378d9b7',
        title: 'A Hillary Christmas - SNL',
        subscription_required: true,
        raw_payload: {
          'thumbnails' => [
            { 'url' => 'https://example.org/1.jpg' },
            { 'url' => 'https://example.org/2.jpg' },
            { 'url' => 'https://example.org/3.jpg' },
            { 'url' => 'https://example.org/4.jpg' }
          ],
          'description' => 'Hello World'
        }
      )
    end

    it 'displays the title' do
      expect(page.text).to include(video.title)
    end

    it 'does not display the video player' do
      expect { find('.video-player') }.to raise_error(Capybara::ElementNotFound)
    end

    it 'asks the user to log in' do
      expect(page.text).to include('Please log in or subscribe to watch this video.')
    end

    it 'allows you to log in and redirects back to the video' do
      click_link 'Log in'
      expect(page.current_path).to eq(new_session_path)

      fill_in 'Username', with: 'test@test.com'
      fill_in 'Password', with: 'password'
      VCR.use_cassette 'zype_session' do
        click_button 'Log in'
      end

      expect(page.current_path).to eq(video_path(video))

      expect(page.text).to include('Logged in successfully.')
      expect(find('.video-player')).to be_present
    end
  end
end
