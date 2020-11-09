# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  after_action  :publish_answer, only: :create

  def create
    @question = Question.find(params[:question_id])
    @answer   = @question.answers.create(answer_params.merge(user: current_user))
  end

  def update
    @answer.update(answer_params)
  end

  def make_best
    @answer.make_best!
    flash[:notice] = "The answer was marked as best."
    redirect_to @answer.question
  end

  def destroy
    @answer.destroy
  end

  private

  def answer_params
    params.require(:answer).permit(:body, files: [], links_attributes: %i[id title url _destroy])
  end

  def publish_answer
    return if @answer.errors.any?

    ActionCable.server.broadcast(
      "questions/#{@answer.question_id}/answers",
      ApplicationController.render(json: @answer)
    )
  end
end
