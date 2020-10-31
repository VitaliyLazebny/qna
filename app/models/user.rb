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
  has_many :authorizations

  def author_of?(resource)
    id.present? && id == resource.try(:user_id)
  end

  def self.find_by_oauth(oauth)
    authorization = Authorization.where(
      provider: oauth.provider,
      uid: oauth.uid.to_s
    ).first

    return authorization.user if authorization

    email = oauth.info[:email]
    user  = User.where(email: email).first

    unless user
      password = Devise.friendly_token(128)
      user = User.create!(
        email: email,
        password: password,
        password_confirmation: password
      )
    end

    user.authorizations.create(
      provider: oauth.provider,
      uid: oauth.uid
    )

    user
  end
end
