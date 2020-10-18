# frozen_string_literal: true

# frozen_string_liWteral: true

require 'rails_helper'

feature 'User can vote for others questions' do
  given(:question)   { create :question }
  given(:questioner) { question.user }
  given(:voter)      { create :user }

  context 'other user', js: true do
    scenario 'user can vote for question' do
      login voter
      visit question_path(question)

      # At the beginning rating is 0
      within "#question-#{question.id} .rating" do
        expect(body).to have_content '1'
        expect(body).to have_link '+1'
        expect(body).to have_link '-1'
      end

      within "#question-#{question.id}" do
        click_on '+1'
      end

      sleep 0.1

      # Rating becomes 1
      within "#question-#{question.id} .rating" do
        expect(body).to have_content '1'
        expect(body).to_not have_link '+1'
        expect(body).to_not have_link '-1'
        expect(body).to have_link 'unvote'
      end

      click_on 'unvote'

      # Rating becomes 0 again
      within "#question-#{question.id} .rating" do
        expect(body).to have_content '0'
        expect(body).to have_link '+1'
        expect(body).to have_link '-1'
        expect(body).to_not have_link 'unvote'
      end
    end
  end

  context 'question', js: true do
    scenario "user can't vote for his own answer" do
      login questioner
      visit question_path(question)

      expect(body).not_to have_selector('.rating')
      expect(body).to_not have_link '+1'
      expect(body).to_not have_link '-1'
      expect(body).to_not have_link 'unvote'
    end
  end
end
