# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::VotesController, type: :controller do
  describe 'POST #create' do
    let!(:answer) { create :answer }
    let!(:user) { create :user }

    context 'logged in user' do
      before { login(user) }

      it 'saves votes' do
        expect { post :create, params: { id: answer.id, value: -1 }, format: :json }
          .to change(Vote, :count).by(1)
      end

    end

    # context 'visitor' do
    #
    # end
  end
end
