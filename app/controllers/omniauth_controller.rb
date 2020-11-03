# frozen_string_literal: true

class OmniauthController < Devise::OmniauthCallbacksController
  def github
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

  def facebook
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

  private

  def oauth_provider
    request.env['omniauth.auth']['provider'].capitalize
  end
end
