# frozen_string_literal: true

require 'rails_helper'

feature 'User can choose the best answer', '
  To award most helpful answer user can make it "best"
' do
  given(:answer)   { create :answer }
  given(:question) { answer.question }
  given(:answerer) { answer.user }
  given(:user)     { create :user }

  context 'other user', js: true do
    scenario 'user can vote for answer' do
      login user
      visit question_path(question)

      # At the beginning rating is 0
      within "#answer-#{answer.id} .rating" do
        expect(body).to have_content '1'
        expect(body).to have_link '+1'
        expect(body).to have_link '-1'
      end

      within "#answer-#{answer.id}" do
        click_on '+1'
      end

      sleep 0.1

      # Rating becomes 1
      within "#answer-#{answer.id} .rating" do
        expect(body).to have_content '1'
        expect(body).to_not have_link '+1'
        expect(body).to_not have_link '-1'
        expect(body).to have_link 'unvote'
      end

      click_on 'unvote'

      # Rating becomes 0 again
      within "#answer-#{answer.id} .rating" do
        expect(body).to have_content '0'
        expect(body).to have_link '+1'
        expect(body).to have_link '-1'
        expect(body).to_not have_link 'unvote'
      end
    end
  end

  context 'answerer', js: true do
    scenario "user can't vote for his own answer" do
      login answerer
      visit question_path(question)

      expect(body).not_to have_selector('.rating')
      expect(body).to_not have_link '+1'
      expect(body).to_not have_link '-1'
      expect(body).to_not have_link 'unvote'
    end
  end
end
