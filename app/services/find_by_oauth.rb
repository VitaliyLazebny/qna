module Services
  class FindByOauth
    attr_reader :email, :provider, :uid

    def initialize(oauth)
      @email    = oauth.dig('info', 'email')
      @provider = oauth['provider']
      @uid      = oauth['uid'].to_s
    end

    def call
      user = Authorization.find_by(provider: provider, uid: uid)&.user
      return user if user

      User.find_or_create_by(email: email) do |user|
        user.password = Devise.friendly_token(128)
        user.authorizations.build(provider: provider, uid: uid)
      end
    end
  end
end
