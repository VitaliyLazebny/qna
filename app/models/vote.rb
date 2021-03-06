# frozen_string_literal: true

class Vote < ApplicationRecord
  validate :validate_absence

  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :value, inclusion: { in: [-1, 1] }

  private

  def validate_absence
    errors.add(:base, 'Already exists.') if Vote.exists?(user_id: user_id, votable: votable)
  end
end
