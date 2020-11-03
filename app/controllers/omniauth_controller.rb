# frozen_string_literal: true

class OmniauthController < Devise::OmniauthCallbacksController
  def github
    login_user
  end

  def facebook
    login_user
  end

  private

  def oauth_provider
    request.env['omniauth.auth']['provider'].capitalize
  end

  def login_user
    @user = Services::FindByOauth
              .new(request.env['omniauth.auth'])
              .call
    if @user&.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: oauth_provider) if is_navigational_format?
    else
      redirect_to root_path, alert: 'something went wrong'
    end
  end
end
