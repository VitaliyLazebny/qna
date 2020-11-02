# frozen_string_literal: true

module Services
  class FindByOauth
    attr_reader :oauth
    attr_reader :user
    attr_reader :authorization

    def initialize(oauth)
      @oauth = oauth
    end

    def call
      return authorization.user if find_authorization

      create_user unless find_user
      create_auth
      user
    end

    private

    def create_user
      password = Devise.friendly_token(128)
      @user = User.create!(
        email: email,
        password: password,
        password_confirmation: password
      )
    end

    def create_auth
      user.authorizations.create(
        provider: oauth['provider'],
        uid: oauth['uid']
      )
    end

    def find_authorization
      @authorization = Authorization.where(
        provider: oauth['provider'],
        uid: oauth['uid'].to_s
      ).first
    end

    def find_user
      @user = User.where(email: email).first
    end

    def email
      oauth.dig('info', 'email')
    end
  end
end
