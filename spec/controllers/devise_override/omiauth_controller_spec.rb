# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeviseOverride::OmniauthController, type: :controller do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  let(:oauth_data) do
    {
      'provider' => 'github',
      'uid' => '123',
      'info' => { 'email' => 'some@mail.com' }
    }
  end

  before(:each) do
    allow(request.env).to receive(:[]).and_call_original
    allow(request.env).to receive(:[]).with('omniauth.auth').and_return(oauth_data)
  end

    context 'does always' do
      it 'looks for user with oauth data' do
        expect_any_instance_of(Services::FindByOauth).to receive(:call)
        get :github
      end

      it 'redirects to root' do
        allow(Services::FindByOauth).to receive(:new).and_return(double('Services::FindByOauth', call: nil))
        get :github

        expect(response).to redirect_to root_path
      end
    end

    context 'user found' do
      let!(:user) { create :user }

      it 'logins user' do
        request.env['omniauth.auth'] = oauth_data
        allow(Services::FindByOauth).to receive(:new).and_return(double('Services::FindByOauth', call: user))
        get :github

        expect(subject.current_user).to eq user
      end
    end

    context 'user doesnt exist' do
      before do
        allow(Services::FindByOauth).to receive(:new).and_return(double('Services::FindByOauth', call: nil))
        get :github
      end

      it "doesn't login" do
        expect(subject.current_user).to_not be
      end
    end
end
