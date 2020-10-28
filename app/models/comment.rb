# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :body, presence: true

  def question_id
    return commentable_id if commentable_type == 'Question'

    commentable.question.id
  end
end
