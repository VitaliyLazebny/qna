# frozen_string_literal: true

require 'rails_helper'

feature 'User can sign-in', '
  In order to ask questions
  User wants to enter the system
' do
  describe 'access top page' do
    it 'can sign in user with Twitter account' do
      visit new_user_session_path
      expect(page).to have_content('Sign in with Twitter')
      mock_auth_hash
      click_link 'Sign in'
      expect(page).to have_content('mockuser') # user name
      expect(page).to have_css('img', src: 'mock_user_thumbnail_url') # user image
      expect(page).to have_content('Sign out')
    end

    it 'can handle authentication error' do
      OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
      visit new_user_session_path
      expect(page).to have_content('Sign in with Twitter')
      click_link 'Sign in'
      expect(page).to have_content('Authentication failed.')
    end
  end
end
