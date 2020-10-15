# frozen_string_literal: true

class Vote < ApplicationRecord
  after_validation :validate_absence

  belongs_to :user
  belongs_to :answer

  validates :value, inclusion: { in: [-1, 1] }

  private

  def validate_absence
    errors.add(:base, 'Already exists.') if Vote.exists?(user_id: user_id, answer: answer_id)
  end
end
