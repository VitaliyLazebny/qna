# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to(:commentable) }
  it { should belong_to(:user) }

  it { should validate_presence_of(:body) }

  context 'returns question_id' do
    it 'if belongs to Question' do
      comment = create :comment
      expect(comment.commentable_type).to eq 'Question'
      expect(comment.question_id).to eq comment.commentable.id
    end

    it 'if belongs to Answer' do
      answer  = create :answer
      comment = create :comment, { commentable: answer }
      expect(comment.commentable_type).to eq 'Answer'
      expect(comment.question_id).to eq comment.commentable.question.id
    end
  end
end
