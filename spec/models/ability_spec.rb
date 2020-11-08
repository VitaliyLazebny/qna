require 'rails_helper'

describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'visitor' do
    let(:user) { nil }

    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }

    it { should_not be_able_to :manage, :all }
  end

  describe 'user' do

  end

  describe 'author' do

  end
end
