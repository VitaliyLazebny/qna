# frozen_string_literal: true

module Votable
  include ActiveSupport::Concern

  included(nil) do
    has_many :votes, as: :votable
  end

  def like(user)
    Vote.create(user: user, answer: self, value: 1)
  end

  def dislike(user)
    Vote.create(user: user, answer: self, value: -1)
  end

  def recall(user)
    Vote.where(user: user, answer: self).destroy_all
  end

  def rating
    Vote.where(answer: self).sum(:value)
  end

  def was_voted_by?(user)
    Vote.exists?(user_id: user.id, answer: self.id )
  end
end
