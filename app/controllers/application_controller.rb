# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :send_user_id_to_front, only: :show

  private

  def send_user_id_to_front
    return unless current_user

    gon.user_id = current_user.id
  end
end
