# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to(:answer) }
  it { should belong_to(:user) }

  it { should validate_inclusion_of(:value).in_array([-1, 1]) }
end
