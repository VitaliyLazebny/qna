# frozen_string_literal: true

require 'rails_helper'

feature 'User can choose the best answer', '
  To award most helpful answer user can make it "best"
' do
  given(:answer)   { create :answer }
  given(:question) { answer.question }
  given(:answerer) { answer.user }
  given(:user)     { create :user }

  context 'no best answer', js: true do
    scenario 'user can vote for answer' do
      login user
      visit question_path(question)

      within "#answer-#{answer.id}" do
        click_on '+1'
      end

      sleep 0.1

      within "#answer-#{answer.id}" do
        expect(body).to have_content 'Rating: 1'
      end
    end
  end
end
