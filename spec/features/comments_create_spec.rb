# frozen_string_literal: true

require 'rails_helper'

feature 'User can comment' do
  given(:question) { create :question }
  given(:answer)   { create :answer }
  given(:comment)  { build  :comment }

  scenario 'user can comment question', js: true do
    Capybara.using_session('visitor') do
      visit question_path(question)
    end

    Capybara.using_session('user') do
      login question.user
      visit question_path(question)

      within '.question .comments' do
        fill_in 'Body', with: comment.body
        click_on 'create'

        expect(page).to have_content comment.body
      end
    end

    Capybara.using_session('visitor') do
      expect(page).to have_content comment.body
    end
  end

  scenario 'user can comment question', js: true do
    Capybara.using_session('visitor') do
      visit question_path(answer.question)
    end

    Capybara.using_session('user') do
      login question.user
      visit question_path(answer.question)

      within '#answers .comments' do
        fill_in 'Body', with: comment.body
        click_on 'create'

        expect(page).to have_content comment.body
      end
    end

    Capybara.using_session('visitor') do
      expect(page).to have_content comment.body
    end
  end
end
