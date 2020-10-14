# frozen_string_literal: true

class Api::VoteController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json

  before_action :authenticate_user!

  def index
    vote = Vote.create(user: current_user, answer: @answer)

    render json: vote
  end

  def create
    render json: []
  end

  def destroy
    render json: []
  end

  private

  def load_answer
    @answer = Answer.find(params[:answer_id])
  end
end
