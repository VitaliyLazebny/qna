# frozen_string_literal: true

class API::VotesController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json

  before_action :authenticate_user!
  before_action :load_answer

  def create
    vote = Vote.create(
      user: current_user,
      answer: @answer,
      value: vote_params[:value]
    )

    render json: vote
  end

  def destroy
    Vote.where(
      user: current_user,
      answer: @answer
    ).destroy_all

    render json: { operation: :success }
  end

  private

  def load_answer
    @answer = Answer.find(params[:answer_id])
  end

  def vote_params
    params.require(:vote).permit(:value)
  end
end
