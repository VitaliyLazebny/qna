# frozen_string_literal: true

module DeviseOverride
  class OmniauthController < Devise::OmniauthCallbacksController
    skip_authorization_check
    before_action :redirect_to_enter_email_page
    before_action :login_user

    def github; end

    def facebook; end

    private

    def omniauth_data
      request.env['omniauth.auth']
    end

    def email
      omniauth_data.dig('info', 'email')
    end

    def oauth_provider
      omniauth_data['provider']&.capitalize
    end

    def login_user
      @user = Services::FindByOauth
              .new(omniauth_data)
              .call
      if @user&.persisted?
        set_flash_message(:notice, :success, kind: oauth_provider) if is_navigational_format?
        sign_in_and_redirect @user, event: :authentication
      else
        redirect_to root_path, alert: 'something went wrong'
      end
    end

    def redirect_to_enter_email_page
      return if email

      flash[:alert] = "Please complete registration since there's no email in social network"
      session[:omniauth] = {
        uid: omniauth_data['uid'].to_s,
        provider: omniauth_data['provider']
      }

      redirect_to new_user_registration_url
    end
  end
end
