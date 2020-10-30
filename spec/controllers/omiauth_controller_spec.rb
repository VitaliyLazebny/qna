# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OmniauthController, type: :controller do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'Github' do
    it 'finds user with oauth data' do
      expect(User).to receive(:find_by_oauth)
      get :github
    end

    it 'logins user if it exists' do
      allow(User).to receive(:find_by_oauth)
      get :github

      expect(response).to redirect_to root_path
    end
    it "doesn't login user which doesn't exist"
  end
end
