# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::VotesController, type: :controller do
  describe 'POST #create' do
    let!(:answer) { create :answer }
    let!(:user) { create :user }

    context 'logged in user' do
      before { login(user) }

      it 'saves -1 vote' do
        expect { post :create, params: { vote: { votable_id: answer.id, votable_type: 'Answer', value: -1 } }, format: :json }
          .to change(Vote, :count).by(1)
      end

      it 'saves 1 vote' do
        expect { post :create, params: { vote: { votable_id: answer.id, votable_type: 'Answer', value: 1 } }, format: :json }
          .to change(Vote, :count).by(1)
      end

      it 'renders proper json' do
        post :create, params: { vote: { votable_id: answer.id, votable_type: 'Answer', value: 1 } }, format: :js
        expect(JSON.parse(response.body)['rating']).to eq(1)
        expect(JSON.parse(response.body)['votable']['id']).to eq(answer.id)
      end

      it 'not saves invalid vote' do
        expect { post :create, params: { vote: { votable_id: answer.id, votable_type: 'Answer', value: 0 } }, format: :json }
          .to_not change(Vote, :count)
      end

      it 'renders proper for invalid vote' do
        post :create, params: { vote: { votable_id: answer.id, votable_type: 'Answer', value: 0 } }, format: :js
        expect(JSON.parse(response.body)['id']).to eq(nil)
      end
    end

    context 'visitor' do
      it 'not saves' do
        expect { post :create, params: { vote: { votable_id: answer.id, votable_type: 'Answer', value: -1 } }, format: :json }
          .to_not change(Vote, :count)
      end

      it 'renders proper response' do
        post :create, params: { vote: { votable_id: answer.id, votable_type: 'Answer', value: 0 } }, format: :js
        expect(response.body).to eq('You need to sign in or sign up before continuing.')
      end
    end
  end
end
