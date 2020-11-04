# frozen_string_literal: true

class Authorization < ApplicationRecord
  belongs_to :user

  validates :uid, presence: true
  validates :provider, presence: true
end
