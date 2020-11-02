# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OmniauthController, type: :controller do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'Github' do
    context 'does always' do
      let(:oauth_data) { { provider: 'github', uid: 123 } }

      it 'looks for user with oauth data' do
        allow(request.env).to receive(:[]).and_call_original
        allow(request.env).to receive(:[]).with('omniauth.auth').and_return(oauth_data)
        expect_any_instance_of(Services::FindByOauth).to receive(:call)
        get :github
      end

      it 'redirects to root' do
        allow_any_instance_of(Services::FindByOauth).to receive(:call)
        get :github

        expect(response).to redirect_to root_path
      end
    end

    context 'user found' do
      let!(:user) { create :user }

      before do
        allow_any_instance_of(Services::FindByOauth)
          .to receive(:call)
          .and_return(user)
        get :github
      end

      it 'logins user' do
        expect(subject.current_user).to eq user
      end
    end

    context 'user doesnt exist' do
      before do
        allow_any_instance_of(Services::FindByOauth)
          .to receive(:call)
        get :github
      end

      it "doesn't login" do
        expect(subject.current_user).to_not be
      end
    end
  end
end
