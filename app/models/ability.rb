# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(_user)
    can :read, :all

    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
