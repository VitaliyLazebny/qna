# frozen_string_literal: true

class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :answer

  validates :value, inclusion: { in: [-1, 1] }
end
