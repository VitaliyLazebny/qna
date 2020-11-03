# frozen_string_literal: true

require 'rails_helper'

feature 'User can sign-in', '
  In order to ask questions
  User wants to enter the system
' do
  describe 'access top page' do
    it 'can sign in user with Facebook account' do
      mock_auth_hash_facebook
      visit new_user_session_path
      click_link 'Sign in with Facebook'
      expect(page).to have_content('Successfully authenticated from Facebook account.')
      expect(page).to have_content('logout')
    end

    it 'can handle authentication error' do
      mock_invalid_auth_facebook
      visit new_user_session_path
      expect(page).to have_content('Sign in with Facebook')
      click_link 'Sign in with Facebook'
      expect(page).to have_content('Invalid credentials')
    end
  end
end
