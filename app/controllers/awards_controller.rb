# frozen_string_literal: true

class AwardsController < ApplicationController
  before_action :authenticate_user!
  skip_authorization_check only: :index

  def index
    @questions = current_user.awards
  end
end
