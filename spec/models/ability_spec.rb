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

    it { should be_able_to :manage, Question }
    it { should be_able_to :manage, Comment }
    it { should be_able_to :manage, Vote }
    it { should be_able_to :manage, ActiveStorage::Attachment }
    it { should be_able_to [:create, :update, :destroy, :make_best], Answer }
  end
end
