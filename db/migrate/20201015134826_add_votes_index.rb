# frozen_string_literal: true

class AddVotesIndex < ActiveRecord::Migration[6.0]
  def change
    add_index :votes, %i[user_id answer_id], unique: true
  end
end
