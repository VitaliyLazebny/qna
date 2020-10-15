# frozen_string_literal: true

module Votable
  include ActiveSupport::Concern

  # has_many :votes

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
end
