# frozen_string_literal: true

require 'rails_helper'

feature 'User can sign-in', '
  In order to ask questions
  User wants to enter the system
' do
  describe 'access top page' do
    it 'can sign in user with Twitter account' do
      mock_auth_hash_github
      visit new_user_session_path
      expect(page).to have_content('Sign in with GitHub')
      click_link 'Sign in with GitHub'
      expect(page).to have_content('Successfully authenticated from Github account.')
      expect(page).to have_content('logout')
    end

    it 'can handle authentication error' do
      mock_invalid_auth_github
      visit new_user_session_path
      expect(page).to have_content('Sign in with GitHub')
      click_link 'Sign in with GitHub'
      expect(page).to have_content('Invalid credentials')
    end
  end
end
