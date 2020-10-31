# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  it { should have_many(:awards) }
  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:answers).dependent(:destroy) }

  context 'author_of? method' do
    let(:user) { create :user }
    let(:unsaved_user) { User.new }
    let(:resource) { Struct.new(:user_id) }

    it "it's author" do
      expect(user).to be_author_of(resource.new(user.id))
    end

    it 'it is not author' do
      expect(user).to_not be_author_of(resource.new('other_user_id'))
    end

    it 'unexpected objects should return false' do
      expect(user).to_not be_author_of('Some string')
    end

    it 'unsaved user should return false' do
      expect(user).to_not be_author_of(resource.new(nil))
    end
  end

  describe 'find_by_oauth method' do
    context 'user has authorization' do
      let(:user) { create :user }
      let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: 123_456) }

      it 'returns user' do
        user.authorizations.create(provider: 'facebook', uid: 123_456)
        expect(User.find_by_oauth(auth)).to eq user
      end
    end

    context 'user has no authorization' do
      let!(:user) { create :user }
      let(:auth) do
        OmniAuth::AuthHash.new(
          provider: 'facebook',
          uid: 123_456,
          info: { email: user.email }
        )
      end

      context 'user already exists' do
        it "doesn't create a new user" do
          expect { User.find_by_oauth(auth) }.to_not change(User, :count)
        end

        it 'creates new authorization for a user' do
          expect { User.find_by_oauth(auth) }.to change(Authorization, :count).by(1)
        end

        it 'created authorization contains proper data' do
          user = User.find_by_oauth(auth)
          authorization = user.authorizations.first

          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid.to_s
        end

        it 'returns user' do
          expect(User.find_by_oauth(auth)).to eq user
        end
      end

      context "user doesn't exist" do
        let(:auth) do
          OmniAuth::AuthHash.new(
            provider: 'facebook',
            uid: 123_456,
            info: { email: 'new.user@email.com' }
          )
        end

        it 'create a new user' do
          expect { User.find_by_oauth(auth) }.to change(User, :count).by(1)
        end

        it "fills user's email" do
          expect(User.find_by_oauth(auth).email).to eq auth[:info][:email]
        end

        it 'creates new authorization for a user' do
          expect { User.find_by_oauth(auth) }.to change(Authorization, :count).by(1)
        end

        it 'created authorization contains proper data' do
          user = User.find_by_oauth(auth)
          authorization = user.authorizations.first

          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid.to_s
        end

        it 'returns user' do
          expect(User.find_by_oauth(auth).class).to eq User
        end
      end
    end
  end
end
