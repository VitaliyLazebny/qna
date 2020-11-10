# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, :all

    if user
      can :manage, Question, user_id: user.id
      can :manage, Comment, user_id: user.id
      can :manage, Vote, user_id: user.id
      can :manage, ActiveStorage::Attachment, record: { user_id: user.id }

      can :create, Answer
      can %i[update destroy], Answer, user_id: user.id
      can :make_best, Answer, question: { user_id: user.id }
    end

    # can :manage, Answer, user_id: user.id
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
