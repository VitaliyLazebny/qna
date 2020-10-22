# frozen_string_literal: true

class AnswersChannel < ApplicationCable::Channel
  def follow(params)
    Rails.logger.error("!!! Received: answers_#{params},  #{params[:question_id]}!!!")
    # stream_from "answers_#{params[:question_id]}"
    stream_from "questions/#{params['question_id']}/answers"
  end
end
