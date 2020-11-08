# frozen_string_literal: true

class AwardsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @questions = current_user.awards
  end
end
