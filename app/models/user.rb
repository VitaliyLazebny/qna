# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github]

  has_many :questions, dependent: :destroy
  has_many :answers,   dependent: :destroy
  has_many :awards
  has_many :votes

  def author_of?(resource)
    id.present? && id == resource.try(:user_id)
  end

  def self.find_by_oauth(oauth); end
end
