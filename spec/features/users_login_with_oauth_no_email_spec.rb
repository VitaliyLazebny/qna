# frozen_string_literal: true

require 'rails_helper'

feature 'User can sign-in with oauth ' do
  given(:user) { FactoryBot.build(:user) }

  it 'can sign in user with Github account', js: true do
    mock_auth_hash_github({ email: false })
    visit new_user_session_path
    click_link 'Sign in with GitHub'
    expect(page).to have_content "Please complete registration since there's no email in social network"
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_on 'Sign up'
    expect(page).to have_content 'A message with a confirmation link has been sent to your email address.'
  end
end
