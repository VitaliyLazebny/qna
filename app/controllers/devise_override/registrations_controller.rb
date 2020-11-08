# frozen_string_literal: true

module DeviseOverride
  class RegistrationsController < Devise::RegistrationsController
    after_action :add_authorization, only: :create

    private

    def add_authorization
      return unless resource&.persisted?
      return unless session[:omniauth]

      resource.authorizations.create(session[:omniauth])
      session.delete(:omniauth)
    end
  end
end
