# frozen_string_literal: true

require 'rails_helper'

feature 'User can see a list of questions', '
  In order to get help someone
  User can see a list of questions
' do
  given(:user)        { create :user }
  given!(:question_1) { create :question, user: user }
  given!(:question_2) { create :question, user: user }
  given(:question)    { build  :question }

  scenario 'user can see question titles at root path' do
    visit root_path

    expect(page).to have_content question_1.title
    expect(page).to have_content question_2.title
  end

  scenario 'user can see question titles at questions list' do
    visit questions_path

    expect(page).to have_content question_1.title
    expect(page).to have_content question_2.title
  end

  scenario 'questions list automatically updates', js: true do
    Capybara.using_session('visitor') do
      visit questions_path
    end

    Capybara.using_session('user') do
      login user
      visit questions_path
      click_on 'Ask question'
      fill_in 'Title', with: question.title
      fill_in 'Body', with: question.body
      click_on 'create'
    end

    Capybara.using_session('visitor') do
      expect(page).to have_content question.title
    end
  end
end
