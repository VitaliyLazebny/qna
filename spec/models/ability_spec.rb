# frozen_string_literal: true

require 'rails_helper'

describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'visitor' do
    let(:user) { nil }

    it { should be_able_to :read, :all }
    it { should_not be_able_to :manage, :all }
  end

  describe 'user' do
    let(:user) { create :user }

    it { should_not be_able_to :manage, create(:question) }
    it { should_not be_able_to :manage, create(:comment) }
    it { should_not be_able_to %i[create update destroy make_best], create(:answer) }
  end

  describe 'author' do
    let(:user) { create :user }

    it { should be_able_to :manage, create(:question, user: user) }
    it { should be_able_to :manage, create(:comment, user: user) }
    it { should be_able_to %i[create update destroy], create(:answer, user: user) }
    it { should be_able_to :make_best, create(:answer, question: create(:question, { user: user })) }
  end
end
