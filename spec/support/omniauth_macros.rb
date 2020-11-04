# frozen_string_literal: true

module OmniauthMacros
  def mock_invalid_auth_facebook
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    OmniAuth.config.logger = Logger.new('/dev/null')
  end

  def mock_auth_hash_facebook
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    OmniAuth.config.mock_auth[:facebook] = {
      'provider' => 'facebook',
      'uid' => '123545',
      'info' => {
        'email' => 'facebook@facebook.com'
      },
      'credentials' => {
        'token' => 'mock_token',
        'secret' => 'mock_secret'
      }
    }
  end

  def mock_invalid_auth_github
    OmniAuth.config.mock_auth[:github] = :invalid_credentials
    OmniAuth.config.logger = Logger.new('/dev/null')
  end

  def mock_auth_hash_github(params = { email: true })
    OmniAuth.config.mock_auth[:github] = {
      'provider' => 'github',
      'uid' => '123545',
      'info' => if params[:email]
                  { 'email' => 'github@github.com' }
                else
                  {}
                end,
      'credentials' => {
        'token' => 'mock_token',
        'secret' => 'mock_secret'
      }
    }
  end
end
