# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable,
         omniauth_providers: %i[github facebook]

  has_many :questions, dependent: :destroy
  has_many :answers,   dependent: :destroy
  has_many :awards
  has_many :votes
  has_many :authorizations

  def author_of?(resource)
    id.present? && id == resource.try(:user_id)
  end
end
