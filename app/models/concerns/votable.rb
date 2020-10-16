# frozen_string_literal: true

module Votable
  include ActiveSupport::Concern

  included(nil) do
    has_many :votes, as: :votable
  end

  def like(user)
    Vote.create(user: user, votable: self, value: 1)
  end

  def dislike(user)
    Vote.create(user: user, votable: self, value: -1)
  end

  def recall(user)
    Vote.where(user: user, votable: self).destroy_all
  end

  def rating
    Vote.where(votable: self).sum(:value)
  end

  def was_voted_by?(user)
    Vote.exists?(user_id: user.id, votable: self)
  end
end
