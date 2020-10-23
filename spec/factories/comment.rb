# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    commentable { create :question }
    user
    body { "Comment Body #{Time.now.to_f}" }
  end
end
