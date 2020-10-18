# frozen_string_literal: true

module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  def like(user)
    votes.create(user: user, value: 1)
  end

  def dislike(user)
    votes.create(user: user, value: -1)
  end

  def recall(user)
    votes.where(user: user).destroy_all
  end

  def rating
    votes.sum(:value)
  end

  def was_voted_by?(user)
    votes.exists?(user_id: user.id)
  end
end
