# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, :all
    can :manage, Question, user_id: user.id
    can :manage, Comment, user_id: user.id
    can :manage, Vote, user_id: user.id

    if user
      can :create, Answer
      can [:update, :destroy], Answer, user_id: user.id
      can :make_best, Answer, question: { user_id: user.id }
    end

    # can :manage, Answer, user_id: user.id
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
